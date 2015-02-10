module API
  module V1
    class SectionsController < APIController
      helper_method :showcase

      def index
        sections = showcase.sections
        @sections = SectionJSONDecorator.decorate_collection(sections)
      end

      def show
        section = Section.find(params[:id])
        @section = SectionJSONDecorator.new(section)
      end

      private

        def showcase
          Showcase.find(params[:showcase_id])
        end
    end
  end
end
