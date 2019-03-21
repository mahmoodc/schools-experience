module Candidates
  module Registrations
    class AddressesController < RegistrationsController
      def new
        @address = Address.new
      end

      def create
        @address = Address.new address_params
        if @address.valid?
          persist @address
          redirect_to new_candidates_school_registrations_subject_preference_path
        else
          render :new
        end
      end

      def edit
        @address = current_registration.address
      end

      def update
        @address = current_registration.address
        @address.assign_attributes address_params

        if @address.valid?
          persist @address
          redirect_to candidates_school_registrations_application_preview_path
        else
          render :edit
        end
      end

    private

      def address_params
        params.require(:candidates_registrations_address).permit \
          :building,
          :street,
          :town_or_city,
          :county,
          :postcode,
          :phone
      end
    end
  end
end