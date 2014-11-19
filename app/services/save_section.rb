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
    if section.save
      fix_order!
      section
    else
      false
    end
  end

  private

    def current_order
      @current_order ||= SectionQuery.new.all_in_exhibit
    end

    def fix_order!
      res = current_order.to_a.insert(section.order, section)
      puts res.inspect
      res.each_with_index do |s, index|
        if s.order != index
          s.order=index
          s.save!
        end
      end
    end
end
