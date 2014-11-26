class Section < ActiveRecord::Base
  validates :image, :item_id, presence: true
end
