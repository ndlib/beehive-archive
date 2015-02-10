module API
  module V1
    class SectionJSONDecorator < Draper::Decorator
      def id
        h.api_v1_section_url(object.id)
      end

      def name
        object.title
      end

      def description
        object.description
      end

      def item
        "#{Rails.configuration.honeycomb_url}/api/v1/collections/#{collection_id}/items/#{item_id}"
      end

      private
        def item_id
          object.item_id
        end

        def collection_id
          object.showcase.exhibit.collection_id
        end
    end
  end
end
