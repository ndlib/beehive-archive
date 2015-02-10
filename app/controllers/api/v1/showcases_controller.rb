module API
  module V1
    class ShowcasesController < APIController
      def index
        showcases = Showcase.all
        @showcases = ShowcaseJSONDecorator.decorate_collection(showcases)
      end

      def show
        showcase = Showcase.find(params[:id])
        @showcase = ShowcaseJSONDecorator.new(showcase)
      end
    end
  end
end
