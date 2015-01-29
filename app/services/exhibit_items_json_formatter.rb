class ExhibitItemsJsonFormatter
  attr_reader :exhibit

  def initialize(exhibit)
    @exhibit = exhibit
  end

  def to_hash(options = {})
    items_json
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end

  private

    def items_json
      CollectionItemsJson.new(exhibit).items_json
    end
end
