class SectionForm
  attr_reader :section

  def initialize(section)
    @section = section
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



end
