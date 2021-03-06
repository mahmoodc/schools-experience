module Candidates
  module Registrations
    class PlacementRequestJob < ApplicationJob
      queue_as :default

      retry_on Notify::RetryableError, wait: A_DECENT_AMOUNT_LONGER, attempts: 5

      def perform(uuid)
        PlacementRequestAction.new(uuid).perform!
      end
    end
  end
end
