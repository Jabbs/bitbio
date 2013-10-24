class AddDefaultForUserBio < ActiveRecord::Migration
  def up
    change_column :users, :bio, :text, default: ""
  end

  def down
    change_column :users, :bio, :text
  end
end
