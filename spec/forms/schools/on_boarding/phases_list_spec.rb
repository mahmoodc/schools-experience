require 'rails_helper'

describe Schools::OnBoarding::PhasesList, type: :model do
  context '#attributes' do
    it { is_expected.to respond_to :primary }
    it { is_expected.to respond_to :secondary }
    it { is_expected.to respond_to :college }
  end
end
