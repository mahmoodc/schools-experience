module Schools
  module OnBoarding
    class KeyStageListsController < OnBoardingsController
      def new
        @key_stage_list = KeyStageList.new
      end

      def create
      end
    end
  end
end
