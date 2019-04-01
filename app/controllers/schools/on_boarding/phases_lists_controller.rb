module Schools
  module OnBoarding
    class PhasesListsController < OnBoardingsController
      def new
        @phases_list = PhasesList.new
      end
    end
  end
end
