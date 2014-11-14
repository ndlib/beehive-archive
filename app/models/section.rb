class Section < ActiveRecord::Base
  validates :title, :image, :item_id, presence: true
end
