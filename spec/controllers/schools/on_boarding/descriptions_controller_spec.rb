require 'rails_helper'

require Rails.root.join("spec", "controllers", "schools", "session_context")

describe Schools::OnBoarding::DescriptionsController, type: :request do
  include_context "logged in DfE user"

  context '#new' do
    let! :school_profile do
      FactoryBot.create \
        :school_profile,
        :with_candidate_requirement,
        :with_fees,
        :with_administration_fee,
        :with_dbs_fee,
        :with_other_fee,
        :with_only_early_years_phase,
        :with_key_stage_list
    end

    before do
      get '/schools/on_boarding/description/new'
    end

    it 'assigns the model' do
      expect(assigns(:description)).to eq Schools::OnBoarding::Description.new
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end

  context '#create' do
    let! :school_profile do
      FactoryBot.create \
        :school_profile,
        :with_candidate_requirement,
        :with_fees,
        :with_administration_fee,
        :with_dbs_fee,
        :with_other_fee,
        :with_only_early_years_phase,
        :with_key_stage_list
    end

    let :params do
      { schools_on_boarding_description: description.attributes }
    end

    before do
      post '/schools/on_boarding/description', params: params
    end

    context 'invalid' do
      let :description do
        Schools::OnBoarding::Description.new
      end

      it "doesn't update the school_profile" do
        expect(school_profile.reload.description).to eq description
      end

      it 'rerenders the new template' do
        expect(response).to render_template :new
      end
    end

    context 'valid' do
      let :description do
        FactoryBot.build :description
      end

      it 'updates the school profile' do
        expect(school_profile.reload.description).to eq description
      end

      it 'redirects to the next step' do
        expect(response).to redirect_to \
          new_schools_on_boarding_candidate_experience_detail_path
      end
    end
  end

  context '#edit' do
    let! :school_profile do
      FactoryBot.create :school_profile, :completed
    end

    before do
      get '/schools/on_boarding/description/edit'
    end

    it 'assigns the model' do
      expect(assigns(:description)).to eq school_profile.description
    end

    it 'renders the edit template' do
      expect(response).to render_template :edit
    end
  end

  context '#update' do
    let! :school_profile do
      FactoryBot.create :school_profile, :completed
    end

    let :params do
      {
        schools_on_boarding_description: description.attributes
      }
    end

    before do
      patch '/schools/on_boarding/description', params: params
    end

    context 'invalid' do
      let :description do
        Schools::OnBoarding::Description.new
      end

      it "doesn't update the school_profile" do
        expect(school_profile.reload.description).not_to eq description
      end

      it 'rerenders the edit template' do
        expect(response).to render_template :edit
      end
    end

    context 'valid' do
      let :description do
        FactoryBot.build :description
      end

      it 'updates the school_profile' do
        expect(school_profile.reload.description).to eq description
      end

      it 'redirects to the school_profile' do
        expect(response).to redirect_to schools_on_boarding_profile_path
      end
    end
  end
end
