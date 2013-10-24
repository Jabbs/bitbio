class AddDefaultToViewCount < ActiveRecord::Migration
  def up
    remove_column :events, :view_count
    add_column :events, :view_count, :integer, default: 0
  end
  
  def down
    remove_column :events, :view_count
    add_column :events, :view_count, :string
  end
end
