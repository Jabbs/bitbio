class ChangeActiveColumnOnProjects < ActiveRecord::Migration
  def up
    change_column :projects, :active, :boolean, default: false
  end

  def down
    change_column :projects, :active, :boolean, default: true
  end
end
