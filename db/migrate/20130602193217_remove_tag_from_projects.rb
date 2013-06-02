class RemoveTagFromProjects < ActiveRecord::Migration
  def up
    remove_column :projects, :tag
  end
  
  def down
    add_column :projects, :tag, :string
  end
end
