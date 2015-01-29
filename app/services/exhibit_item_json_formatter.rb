class ExhibitItemJsonFormatter
  attr_reader :exhibit, :item_id

  def initialize(exhibit, item_id)
    @exhibit = exhibit
    @item_id = item_id
  end

  def to_hash(options = {})
    item_json
  end

  def to_json(options = {})
    to_hash.to_json(options)
  end

  private

    def item_json
      CollectionItemsJson.new(exhibit).item_json(item_id)
    end
end
