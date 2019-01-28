require 'rails_helper'

describe Bookings::School, type: :model do
  describe 'Scopes' do
    subject { Bookings::School }

    context 'Full text searching on Name' do
      # provided by FullTextSearch
      it { is_expected.to respond_to(:search_by_name) }
    end

    context 'Geographic searching by Coordinates' do
      # provided by FullTextSearch
      it { is_expected.to respond_to(:close_to) }
    end
  end

  describe 'Validation' do
    context 'Name' do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_most(128) }
    end
  end
end