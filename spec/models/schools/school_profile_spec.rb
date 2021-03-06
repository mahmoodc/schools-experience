require 'rails_helper'

describe Schools::SchoolProfile, type: :model do
  context 'attributes' do
    it do
      is_expected.to have_db_column(:bookings_school_id).of_type :integer
    end

    it do
      is_expected.to \
        have_db_column(:candidate_requirement_dbs_requirement).of_type :string
    end

    it do
      is_expected.to \
        have_db_column(:candidate_requirement_dbs_policy).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:candidate_requirement_requirements).of_type :boolean
    end

    it do
      is_expected.to \
        have_db_column(:candidate_requirement_requirements_details).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:fees_administration_fees).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:fees_dbs_fees).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:fees_other_fees).of_type :boolean
    end

    %w(administration_fee dbs_fee other_fee).each do |fee|
      it do
        is_expected.to \
          have_db_column(:"#{fee}_amount_pounds")
            .of_type(:decimal).with_options(precision: 6, scale: 2)
      end

      it do
        is_expected.to have_db_column(:"#{fee}_description").of_type :text
      end

      it do
        is_expected.to have_db_column(:"#{fee}_interval").of_type :string
      end

      it do
        is_expected.to have_db_column(:"#{fee}_payment_method").of_type :text
      end
    end

    it do
      is_expected.to have_db_column(:phases_list_primary).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:phases_list_secondary).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:phases_list_college).of_type :boolean
    end

    it do
      is_expected.to \
        have_db_column(:phases_list_secondary_and_college).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:description_details).of_type :text
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_business_dress).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_cover_up_tattoos).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_remove_piercings).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_smart_casual).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_other_dress_requirements).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_other_dress_requirements_detail).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_parking_provided).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_parking_details).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_nearby_parking_details).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_disabled_facilities).of_type :boolean
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_disabled_facilities_details).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_start_time).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_end_time).of_type :string
    end

    it do
      is_expected.to have_db_column(:candidate_experience_detail_times_flexible).of_type :boolean
    end

    it do
      is_expected.to \
        have_db_column(:candidate_experience_detail_times_flexible_details).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:experience_outline_candidate_experience).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:experience_outline_provides_teacher_training).of_type :boolean
    end

    it do
      is_expected.to \
        have_db_column(:experience_outline_teacher_training_details).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:experience_outline_teacher_training_url).of_type :string
    end

    it do
      is_expected.to have_db_column(:admin_contact_full_name).of_type :string
    end

    it do
      is_expected.to have_db_column(:admin_contact_email).of_type :string
    end

    it do
      is_expected.to have_db_column(:admin_contact_email).of_type :string
    end

    it do
      is_expected.to \
        have_db_column(:availability_description_description).of_type :text
    end

    it do
      is_expected.to \
        have_db_column(:availability_preference_fixed).of_type(:boolean)
    end

    it do
      is_expected.to \
        have_db_column(:confirmation_acceptance).of_type(:boolean)
    end
  end

  context 'relationships' do
    it { is_expected.to have_many(:profile_subjects) }
    it { is_expected.to have_many(:subjects) }
    it { is_expected.to belong_to(:bookings_school) }
  end

  context 'delegation' do
    it { is_expected.to delegate_method(:urn).to(:bookings_school) }
  end

  context 'validations' do
    it do
      is_expected.to validate_presence_of :bookings_school
    end
  end

  context 'associations' do
    context 'subjects' do
      let(:bookings_school) { create(:bookings_school) }
      subject { described_class.create!(bookings_school: bookings_school) }

      let :bookings_subject do
        FactoryBot.create :bookings_subject
      end

      before do
        subject.subjects << bookings_subject
      end

      context '#subjects' do
        it 'only returns subjects' do
          expect(subject.subjects.to_a).to eq [bookings_subject]
        end
      end
    end
  end

  context 'values from form models' do
    let(:bookings_school) { create(:bookings_school) }
    let :model do
      described_class.new bookings_school: bookings_school
    end

    context '#candidate_requirement' do
      let :form_model do
        FactoryBot.build :candidate_requirement
      end

      before do
        model.candidate_requirement = form_model
      end

      it 'sets candidate_requirement_dbs_requirement' do
        expect(model.candidate_requirement_dbs_requirement).to eq \
          form_model.dbs_requirement
      end

      it 'sets candidate_requirement_dbs_policy' do
        expect(model.candidate_requirement_dbs_policy).to eq \
          form_model.dbs_policy
      end

      it 'sets candidate_requirement_requirements' do
        expect(model.candidate_requirement_requirements).to eq \
          form_model.requirements
      end

      it 'sets candidate_requirement_requirements_details' do
        expect(model.candidate_requirement_requirements_details).to eq \
          form_model.requirements_details
      end

      it 'returns the form model' do
        expect(model.candidate_requirement).to eq form_model
      end
    end

    context '#fees' do
      let :form_model do
        FactoryBot.build :fees
      end

      before do
        model.fees = form_model
      end

      it 'sets fees_administration_fees' do
        expect(model.fees_administration_fees).to eq \
          form_model.administration_fees
      end

      it 'sets fees_dbs_fees' do
        expect(model.fees_dbs_fees).to eq form_model.dbs_fees
      end

      it 'sets fees_other_fees' do
        expect(model.fees_other_fees).to eq form_model.other_fees
      end

      it 'returns the form model' do
        expect(model.fees).to eq form_model
      end
    end

    context 'school_fees' do
      %w(administration_fee dbs_fee other_fee).each do |fee|
        context fee do
          let :form_model do
            FactoryBot.build fee
          end

          before do
            model.public_send "#{fee}=", form_model
          end

          it "sets #{fee}_amount_pounds" do
            expect(model.public_send("#{fee}_amount_pounds")).to \
              eq form_model.amount_pounds
          end

          it "sets #{fee}_description" do
            expect(model.public_send("#{fee}_description")).to \
              eq form_model.description
          end

          it "sets #{fee}_interval" do
            expect(model.public_send("#{fee}_interval")).to eq \
              form_model.interval
          end

          it "sets #{fee}_payment_method" do
            expect(model.public_send("#{fee}_payment_method")).to \
              eq form_model.payment_method
          end

          it 'returns the form model' do
            expect(model.public_send(fee)).to eq form_model
          end
        end
      end
    end

    context '#phases_list' do
      let :form_model do
        FactoryBot.build :phases_list
      end

      before do
        model.phases_list = form_model
      end

      it 'sets phases_list_primary' do
        expect(model.phases_list_primary).to eq form_model.primary
      end

      it 'sets phases_list_secondary' do
        expect(model.phases_list_secondary).to eq form_model.secondary
      end

      it 'sets phases_list_college' do
        expect(model.phases_list_college).to eq form_model.college
      end

      it 'sets phases_list_secondary_and_college' do
        expect(model.phases_list_secondary_and_college).to \
          eq form_model.secondary_and_college
      end

      it 'returns the form model' do
        expect(model.phases_list).to eq form_model
      end
    end

    context '#key_stage_list' do
      let :form_model do
        FactoryBot.build :key_stage_list
      end

      before do
        model.key_stage_list = form_model
      end

      it 'sets early_years' do
        expect(model.key_stage_list.early_years).to eq form_model.early_years
      end

      it 'sets key_stage_1' do
        expect(model.key_stage_list.key_stage_1).to eq form_model.key_stage_1
      end

      it 'sets key_stage_2' do
        expect(model.key_stage_list.key_stage_2).to eq form_model.key_stage_2
      end
    end

    context '#description' do
      let :form_model do
        FactoryBot.build :description
      end

      before do
        model.description = form_model
      end

      it 'sets details' do
        expect(model.description_details).to eq form_model.details
      end

      it 'returns the form model' do
        expect(model.description).to eq form_model
      end
    end

    context '#candidate_experience_detail' do
      let :form_model do
        FactoryBot.build :candidate_experience_detail
      end

      before do
        model.candidate_experience_detail = form_model
      end

      %i(
        business_dress
        cover_up_tattoos
        remove_piercings
        smart_casual
        other_dress_requirements
        other_dress_requirements_detail
        parking_provided
        parking_details
        nearby_parking_details
        disabled_facilities
        disabled_facilities_details
        start_time
        end_time
        times_flexible
        times_flexible_details
      ).each do |attribute|
        it "sets #{attribute} correctly" do
          expect(model.send("candidate_experience_detail_#{attribute}")).to \
            eq form_model.send attribute
        end
      end

      it 'returns the form model' do
        expect(model.candidate_experience_detail).to eq form_model
      end
    end

    context '#experience_outline' do
      let :form_model do
        FactoryBot.build :experience_outline
      end

      before do
        model.experience_outline = form_model
      end

      %i(
        candidate_experience
        provides_teacher_training
        teacher_training_details
        teacher_training_url
      ).each do |attribute|
        it "sets #{attribute} correctly" do
          expect(model.send("experience_outline_#{attribute}")).to \
            eq form_model.send attribute
        end
      end

      it 'returns the form model' do
        expect(model.experience_outline).to eq form_model
      end
    end

    context '#admin_contact' do
      let :form_model do
        FactoryBot.build :admin_contact
      end

      before do
        model.admin_contact = form_model
      end

      %i(full_name phone email).each do |attribute|
        it "sets #{attribute} correctly" do
          expect(model.send("admin_contact_#{attribute}")).to \
            eq form_model.send attribute
        end
      end

      it 'returns the form model' do
        expect(model.admin_contact).to eq form_model
      end
    end

    context '#availability_description' do
      let :form_model do
        FactoryBot.build :availability_description
      end

      before do
        model.availability_description = form_model
      end

      it 'sets description correctly' do
        expect(model.availability_description.description).to \
          eq form_model.description
      end

      it 'returns the form model' do
        expect(model.availability_description).to eq form_model
      end
    end

    context '#availability_preference' do
      let :form_model do
        FactoryBot.build :availability_preference, fixed: true
      end

      before do
        model.availability_preference = form_model
      end

      it 'sets the availability fixed correctly' do
        expect(model.availability_preference.fixed).to be true
      end

      it 'returns the form model' do
        expect(model.availability_preference).to eq form_model
      end
    end

    context '#confirmation' do
      let :form_model do
        FactoryBot.build :confirmation
      end

      before do
        model.confirmation = form_model
      end

      it 'returns the form model' do
        expect(model.confirmation).to eq form_model
      end
    end
  end

  context 'callbacks' do
    context 'before_validation' do
      context 'when administration_fee no longer makes sense' do
        let :school_profile do
          FactoryBot.create \
            :school_profile, :with_fees, :with_administration_fee
        end

        before do
          school_profile.update! \
            fees: FactoryBot.build(:fees, administration_fees: false)
        end

        it 'resets administration_fee' do
          expect(school_profile.administration_fee).to \
            eq Schools::OnBoarding::AdministrationFee.new
        end
      end

      context 'when dbs_fee no longer makes sense' do
        let :school_profile do
          FactoryBot.create :school_profile, :with_fees, :with_dbs_fee
        end

        before do
          school_profile.update! fees: FactoryBot.build(:fees, dbs_fees: false)
        end

        it 'resets dbs_fee' do
          expect(school_profile.dbs_fee).to eq Schools::OnBoarding::DBSFee.new
        end
      end

      context 'when other_fee no longer makes sense' do
        let :school_profile do
          FactoryBot.create :school_profile, :with_fees, :with_other_fee
        end

        before do
          school_profile.update! \
            fees: FactoryBot.build(:fees, other_fees: false)
        end

        it 'resets other_fee' do
          expect(school_profile.other_fee).to \
            eq Schools::OnBoarding::OtherFee.new
        end
      end

      context 'when key_stage_list no longer makes sense' do
        let :school_profile do
          FactoryBot.create :school_profile, :with_phases, :with_key_stage_list
        end

        before do
          school_profile.update! \
            phases_list: Schools::OnBoarding::PhasesList.new(primary: false)
        end

        it 'resets key stage list' do
          expect(school_profile.reload.key_stage_list).to \
            eq Schools::OnBoarding::KeyStageList.new
        end
      end

      context 'when secondary_subjects no longer makes sense' do
        let :school_profile do
          FactoryBot.create :school_profile, :with_phases, :with_subjects
        end

        before do
          school_profile.update! \
            phases_list: Schools::OnBoarding::PhasesList.new(secondary: false)
        end

        it 'removes subjects' do
          expect(school_profile.reload.subjects).to be_empty
        end
      end

      context 'when availability_description no longer makes sense' do
        let :school_profile do
          FactoryBot.create \
            :school_profile,
            :with_availability_preference,
            :with_availability_description
        end

        before do
          school_profile.update! availability_preference: \
            Schools::OnBoarding::AvailabilityPreference.new(fixed: true)
        end

        it 'removes the availability_description' do
          expect(school_profile.reload.availability_description).to \
            eq Schools::OnBoarding::AvailabilityDescription.new
        end
      end
    end
  end

  context '#requires_subjects?' do
    let :school_profile do
      FactoryBot.create :school_profile
    end

    context 'when phases_list includes secondary' do
      before do
        school_profile.phases_list = \
          FactoryBot.build :phases_list, secondary: true, college: false
      end

      it 'returns true' do
        expect(school_profile.requires_subjects?).to be true
      end
    end

    context 'when phases_list includes college' do
      before do
        school_profile.phases_list = \
          FactoryBot.build :phases_list, secondary: false, college: true
      end

      it 'returns true' do
        expect(school_profile.requires_subjects?).to be true
      end
    end

    context "when phases_list doesn't include college or secondary" do
      it 'returns false' do
        expect(school_profile.requires_subjects?).to be false
      end
    end
  end
end
