module API
  module V1
    class ShowcaseJSONDecorator < Draper::Decorator
      def id
        h.api_v1_exhibit_showcase_url(object.exhibit_id, object.id)
      end

      def name
        object.title
      end

      def description
        object.description
      end

      def sections
        h.api_v1_exhibit_showcase_sections_url(object.exhibit_id, object.id)
      end
    end
  end
end
