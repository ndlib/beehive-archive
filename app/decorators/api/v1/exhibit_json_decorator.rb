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

      def collection
        "#{Rails.configuration.honeycomb_url}/api/v1/collections/#{collection_id}"
      end

      private

        def collection_id
          object.collection_id
        end
    end
  end
end
