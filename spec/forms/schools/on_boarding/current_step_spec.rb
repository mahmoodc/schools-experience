require 'rails_helper'

describe Schools::OnBoarding::CurrentStep do
  let! :secondary_phase do
    FactoryBot.create :bookings_phase, :secondary
  end

  let! :college_phase do
    FactoryBot.create :bookings_phase, :college
  end

  context '.for' do
    let :returned_step do
      described_class.for school_profile
    end

    context 'candidate_requirement required' do
      let :school_profile do
        FactoryBot.build_stubbed :school_profile
      end

      it 'returns :candidate_requirement' do
        expect(returned_step).to eq :candidate_requirement
      end
    end

    context 'candidate_requirement not required' do
      context 'fees required' do
        let :school_profile do
          FactoryBot.build_stubbed :school_profile, :with_candidate_requirement
        end

        it 'returns :fees' do
          expect(returned_step).to eq :fees
        end
      end

      context 'fees not required' do
        context 'administration_fee required' do
          let :school_profile do
            FactoryBot.build_stubbed :school_profile,
              :with_candidate_requirement,
              fees_administration_fees: true,
              fees_dbs_fees: false,
              fees_other_fees: false
          end

          it 'returns :administration_fee' do
            expect(returned_step).to eq :administration_fee
          end
        end

        context 'administration_fee not required' do
          context 'dbs_fee required' do
            let :school_profile do
              FactoryBot.build_stubbed :school_profile,
                :with_candidate_requirement,
                fees_administration_fees: false,
                fees_dbs_fees: true,
                fees_other_fees: false
            end

            it 'returns :dbs_fee' do
              expect(returned_step).to eq :dbs_fee
            end
          end

          context 'dbs_fee not required' do
            context 'other_fees required' do
              let :school_profile do
                FactoryBot.build_stubbed :school_profile,
                  :with_candidate_requirement,
                  fees_administration_fees: false,
                  fees_dbs_fees: false,
                  fees_other_fees: true
              end

              it 'returns :other_fees' do
                expect(returned_step).to eq :other_fee
              end
            end

            context 'other_fees not required' do
              context 'phases_list required' do
                let :school_profile do
                  FactoryBot.build_stubbed :school_profile,
                    :with_candidate_requirement,
                    fees_administration_fees: false,
                    fees_dbs_fees: false,
                    fees_other_fees: false
                end

                it 'returns :phases_list' do
                  expect(returned_step).to eq :phases_list
                end
              end

              context 'phases_list not required' do
                context 'key_stage_list required' do
                  let :school_profile do
                    FactoryBot.build_stubbed :school_profile,
                      :with_candidate_requirement,
                      :with_fees,
                      :with_administration_fee,
                      :with_dbs_fee,
                      :with_other_fee,
                      :with_phases
                  end

                  it 'returns :key_stage_list' do
                    expect(returned_step).to eq :key_stage_list
                  end
                end

                context 'key_stage_list not required' do
                  context 'subjects required' do
                    let :school_profile do
                      FactoryBot.build_stubbed :school_profile,
                        :with_candidate_requirement,
                        :with_fees,
                        :with_administration_fee,
                        :with_dbs_fee,
                        :with_other_fee,
                        :with_phases,
                        :with_key_stage_list
                    end

                    it 'returns subjects' do
                      expect(returned_step).to eq :subjects
                    end
                  end

                  context 'subjects not required' do
                    context 'description required' do
                      let :school_profile do
                        FactoryBot.create :school_profile,
                          :with_candidate_requirement,
                          :with_fees,
                          :with_administration_fee,
                          :with_dbs_fee,
                          :with_other_fee,
                          :with_phases,
                          :with_key_stage_list,
                          :with_subjects
                      end

                      it 'returns :description' do
                        expect(returned_step).to eq :description
                      end
                    end

                    context 'description not required' do
                      context 'candidate_experience_detail required' do
                        let :school_profile do
                          FactoryBot.create :school_profile,
                            :with_candidate_requirement,
                            :with_fees,
                            :with_administration_fee,
                            :with_dbs_fee,
                            :with_other_fee,
                            :with_phases,
                            :with_key_stage_list,
                            :with_subjects,
                            :with_description
                        end

                        it 'returns :candidate_experience_detail' do
                          expect(returned_step).to \
                            eq :candidate_experience_detail
                        end
                      end

                      context 'candidate_experience_detail not required' do
                        context 'availability_preference required' do
                          let :school_profile do
                            FactoryBot.create :school_profile,
                              :with_candidate_requirement,
                              :with_fees,
                              :with_administration_fee,
                              :with_dbs_fee,
                              :with_other_fee,
                              :with_phases,
                              :with_key_stage_list,
                              :with_subjects,
                              :with_description,
                              :with_candidate_experience_detail
                          end

                          it 'returns :availability_preference' do
                            expect(returned_step).to \
                              eq :availability_preference
                          end
                        end

                        context 'availability_preference not required' do
                          context 'availability required' do
                            let :school_profile do
                              FactoryBot.create :school_profile,
                                :with_candidate_requirement,
                                :with_fees,
                                :with_administration_fee,
                                :with_dbs_fee,
                                :with_other_fee,
                                :with_phases,
                                :with_key_stage_list,
                                :with_subjects,
                                :with_description,
                                :with_candidate_experience_detail,
                                :with_availability_preference
                            end

                            it 'returns :availability' do
                              expect(returned_step).to eq :availability_description
                            end
                          end

                          context 'availability not required' do
                            context 'experience_outline requred' do
                              let :school_profile do
                                FactoryBot.create :school_profile,
                                  :with_candidate_requirement,
                                  :with_fees,
                                  :with_administration_fee,
                                  :with_dbs_fee,
                                  :with_other_fee,
                                  :with_phases,
                                  :with_key_stage_list,
                                  :with_subjects,
                                  :with_description,
                                  :with_candidate_experience_detail,
                                  :with_availability_preference,
                                  :with_availability_description
                              end

                              it 'returns :experience_outline' do
                                expect(returned_step).to \
                                  eq :experience_outline
                              end
                            end

                            context 'experience_outline not required' do
                              context 'admin_contact required' do
                                let :school_profile do
                                  FactoryBot.create :school_profile,
                                    :with_candidate_requirement,
                                    :with_fees,
                                    :with_administration_fee,
                                    :with_dbs_fee,
                                    :with_other_fee,
                                    :with_phases,
                                    :with_key_stage_list,
                                    :with_subjects,
                                    :with_description,
                                    :with_candidate_experience_detail,
                                    :with_availability_preference,
                                    :with_availability_description,
                                    :with_experience_outline
                                end

                                it 'returns :admin_contact' do
                                  expect(returned_step).to eq :admin_contact
                                end
                              end

                              context 'admin_contact not required' do
                                let :school_profile do
                                  FactoryBot.create :school_profile,
                                    :with_candidate_requirement,
                                    :with_fees,
                                    :with_administration_fee,
                                    :with_dbs_fee,
                                    :with_other_fee,
                                    :with_phases,
                                    :with_key_stage_list,
                                    :with_subjects,
                                    :with_description,
                                    :with_candidate_experience_detail,
                                    :with_availability_preference,
                                    :with_availability_description,
                                    :with_experience_outline,
                                    :with_admin_contact
                                end

                                it 'returns :COMPLETED' do
                                  expect(returned_step).to eq :COMPLETED
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
