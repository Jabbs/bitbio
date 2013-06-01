class RemoveTagFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :tag
  end
end
