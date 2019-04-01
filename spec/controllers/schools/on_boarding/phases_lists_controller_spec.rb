require 'rails_helper'

describe Schools::OnBoarding::PhasesListsController, type: :request do
  context '#new' do
    before do
      get '/schools/on_boarding/phases_list/new'
    end

    it 'assigns the model' do
      expect(assigns(:phases_list)).to eq Schools::OnBoarding::PhasesList.new
    end

    it 'renders the new template' do
      expect(response).to render_template :new
    end
  end
end
