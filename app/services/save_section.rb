class SaveSection
  attr_reader :section, :params

  def self.call(section, params)
    new(section, params).save
  end

  def initialize(section, params)
    @section = section
    @params = params
  end

  def save
    section.attributes = params

    current_order
    if section.save && fix_order!
      section
    else
      false
    end
  end

  private

    def current_order
      @current_order ||= SectionQuery.new.all_in_showcase(section.showcase)
    end

    def fix_order!
      ReorderSections.call(current_order, section)
    end
end
