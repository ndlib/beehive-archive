module API
  module V1
    class ExhibitJSONDecorator < Draper::Decorator
      def id
        h.api_v1_exhibit_url(object.id)
      end

      def name
        object.title
      end

      def description
        object.description
      end

      def showcases
        h.api_v1_exhibit_showcases_url(object.id)
      end
    end
  end
end
