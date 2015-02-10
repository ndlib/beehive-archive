module API
  module V1
    class ExhibitsController < APIController
      def index
        exhibits = Exhibit.all
        @exhibits = ExhibitJSONDecorator.decorate_collection(exhibits)
      end

      def show
        exhibit = Exhibit.find(params[:id])
        @exhibit = ExhibitJSONDecorator.new(exhibit)
      end
    end
  end
end
