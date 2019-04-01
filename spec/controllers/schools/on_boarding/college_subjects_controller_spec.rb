require 'rails_helper'

describe Schools::OnBoarding::CollegeSubjectsController, type: :request do
  let! :secondary_phase do
    FactoryBot.create :bookings_phase, :secondary
  end

  let! :college_phase do
    FactoryBot.create :bookings_phase, :college
  end

  let! :bookings_subject do
    FactoryBot.create :bookings_subject
  end

  let! :school_profile do
    FactoryBot.create \
      :school_profile,
      :with_candidate_requirement,
      :with_fees,
      :with_administration_fee,
      :with_dbs_fee,
      :with_other_fee,
      :with_phases,
      :with_key_stage_list,
      :with_secondary_subjects
  end

  context '#new' do
    before do
      get '/schools/on_boarding/college_subjects/new'
    end

    it 'assigns the model' do
      expect(assigns(:subject_list)).to eq Schools::OnBoarding::SubjectList.new
    end

    it 'renders the new template' do
      expect(response.body).to render_template :new
    end
  end

  context '#create' do
    before do
      post '/schools/on_boarding/college_subjects', params: params
    end

    context 'invalid' do
      let :params do
        {
          schools_on_boarding_subject_list: { subject_ids: [] }
        }
      end

      it "doesn't update the school profile" do
        expect(school_profile.reload.college_subjects).to be_empty
      end

      it 'rerenders the new template' do
        expect(response).to render_template :new
      end
    end

    context 'valid' do
      let :params do
        {
          schools_on_boarding_subject_list: {
            subject_ids: [bookings_subject.id]
          }
        }
      end

      it 'updates the school profile with the college subjects' do
        expect(school_profile.reload.college_subjects).to eq [bookings_subject]
      end

      it 'redirects to the next step' do
        expect(response).to redirect_to new_schools_on_boarding_specialisms_path
      end
    end
  end
end
