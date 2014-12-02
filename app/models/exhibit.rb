class Exhibit < ActiveRecord::Base
  has_many :showcases

  validates :title, presence: true

  def items_json_url
    "#{Rails.configuration.honeycomb_url}/collections/#{collection_id}/items/all.json?include=tiled_images"
  end

end
