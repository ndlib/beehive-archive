module API
  module V1
    class ShowcaseJSONDecorator < Draper::Decorator
      def id
        h.api_v1_showcase_url(object.id)
      end

      def name
        object.title
      end

      def description
        object.description
      end

      # TODO associate an item directly with the showcase
      def item
        if first_section
          first_section.item
        else
          nil
        end
      end

      def sections
        h.api_v1_showcase_sections_url(object.id)
      end

      def exhibit
        h.api_v1_exhibit_url(object.exhibit_id)
      end

      private
        def first_section
          if first_section_object
            @first_section ||= SectionJSONDecorator.new(first_section_object)
          else
            nil
          end
        end

        def first_section_object
          object.sections.first
        end
    end
  end
end
