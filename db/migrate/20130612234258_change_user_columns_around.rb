class ChangeUserColumnsAround < ActiveRecord::Migration
  def up
    add_column :users, :facility_id, :integer
    add_column :users, :lab_id, :integer
  end

  def down
    remove_column :users, :facility_id
    remove_column :users, :lab_id
  end
end
