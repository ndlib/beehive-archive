class Exhibit < ActiveRecord::Base
  has_many :showcases

  validates :title, presence: true

  def items_json_url
    "#{Rails.configuration.honeycomb_url}/api/collections/#{collection_id}/items.json?include=image"
  end

  def item_json_url(item_id)
    "#{Rails.configuration.honeycomb_url}/api/collections/#{collection_id}/items/#{item_id}.json?include=image"
  end

end
