module Schools
  module OnBoarding
    class SecondarySubjectsListController < OnBoardingsController
      def new
      end

      def create
        current_school_profile.update! secondary_subjects_params
      end

    private

      def secondary_subjects_params
        params.require(:schools_school_profile).permit \
          phase_subjects_attributes: [
            :id,
            :_destroy,
            :bookings_phase_id,
            :bookings_subject_id
          ]
      end
    end
  end
end
