class Section < ActiveRecord::Base
  belongs_to :showcase

  validates :image, :item_id, :showcase, :display_type, presence: true

  validates :display_type,  inclusion: { in: %w(image text) }
end
