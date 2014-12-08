class Section < ActiveRecord::Base
  belongs_to :showcase

  validates :image, :item_id, :showcase, presence: true
end
