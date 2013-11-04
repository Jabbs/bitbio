class RemoveUserGeneratedFromFacilities < ActiveRecord::Migration
  def up
    remove_column :facilities, :user_generated
    add_column :locations, :display_on_map, :boolean, default: true
  end

  def down
    add_column :facilities, :user_generated, :boolean, default: false
    remove_column :locations, :display_on_map
  end
end
