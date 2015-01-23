class SectionForm
  attr_reader :section

  def self.build_from_params(controller)
    if controller.params[:id]
      section = Section.find(controller.params[:id])
    else
      section = Showcase.find(controller.params[:showcase_id]).sections.build( (controller.params[:section] || {}) )
      section.display_type = 'text'
    end

    new(section)
  end

  def initialize(section)
    @section = section
    validate!
  end

  def form_url
    [ section.showcase.exhibit, section.showcase, section ]
  end

  def form_partial
    if section.display_type == 'image'
      'image_form'
    elsif section.display_type == 'text'
      'text_form'
    else
      raise "Implment section form for type #{section.display_type}"
    end
  end


  def title
    section.title
  end

  private

      def validate!
        if section.order.blank?
          raise "Section passed to section form requires an order "
        end
        if section.display_type.blank?
          raise "Section passed to SectionForm requires a display_type"
        end
      end

end
