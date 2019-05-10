class AddPhaseNumberToBookingsPlacementRequest < ActiveRecord::Migration[5.2]
  class Bookings::PlacementRequest < ApplicationRecord; end

  def change
    add_column :bookings_placement_requests, :phase_number, :integer

    Bookings::PlacementRequest.update_all phase_number: Rails.application.config.x.phase
  end
end
