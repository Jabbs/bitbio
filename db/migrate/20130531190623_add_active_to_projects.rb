class AddActiveToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :active, :boolean, default: true
    add_column :projects, :expiration_date, :date
    add_index :projects, :active
  end
end
