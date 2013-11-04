class ChangeScienceTypeToProtocolInProjects < ActiveRecord::Migration
  def up
    rename_column :projects, :science_type, :protocol
    rename_index :projects, "index_projects_on_science_type", "index_projects_on_protocol"
  end

  def down
    rename_column :projects, :protocol, :science_type
  end
end
