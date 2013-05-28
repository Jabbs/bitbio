class AddTagToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :tag, :string
    add_index :projects, :tag
  end
end
