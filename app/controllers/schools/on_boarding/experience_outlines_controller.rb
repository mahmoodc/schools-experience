module Schools
  module OnBoarding
    class ExperienceOutlinesController < OnBoardingsController
      def new
        @experience_outline = \
          ExperienceOutline.new_from_bookings_school current_school
      end

      def create
        @experience_outline = ExperienceOutline.new experience_outline_params

        if @experience_outline.valid?
          current_school_profile.update! experience_outline: @experience_outline
          redirect_to next_step_path(current_school_profile)
        else
          render :new
        end
      end

      def edit
        @experience_outline = current_school_profile.experience_outline
      end

      def update
        @experience_outline = ExperienceOutline.new experience_outline_params

        if @experience_outline.valid?
          current_school_profile.update! experience_outline: @experience_outline
          redirect_to next_step_path(current_school_profile)
        else
          render :edit
        end
      end

    private

      def experience_outline_params
        params.require(:schools_on_boarding_experience_outline).permit \
          :candidate_experience,
          :provides_teacher_training,
          :teacher_training_details,
          :teacher_training_url
      end
    end
  end
end
