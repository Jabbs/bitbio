class AddSearchableToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :searchable, :boolean, default: true
    add_index :projects, :searchable
  end
end
