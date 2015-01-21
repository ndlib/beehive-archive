class MigrateExistingSections < ActiveRecord::Migration
  def change
    Section.all.each do | s |
      if s.type.nil?
        s.display_type = 'image'
        s.save!
      end
    end
  end
end
