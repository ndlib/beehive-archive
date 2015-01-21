class AddTypeToSection < ActiveRecord::Migration
  def change
    add_column :sections, :display_type, :string
    add_index :sections, :display_type
  end
end
