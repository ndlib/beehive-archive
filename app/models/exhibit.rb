class Exhibit
  include ActiveModel::Model
  attr_accessor :id, :collection_id, :title

  def items_json_url
    "#{Rails.configuration.honeycomb_url}/collections/#{collection_id}/items/all.json?include=tiled_images"
  end

  def self.find(id)
    new(id: id, collection_id: id, title: "My Exhibit")
  end
end
