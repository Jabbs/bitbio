class AddVisabilityToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :visability, :string, default: "public"
    add_index :projects, :visability
  end
end
