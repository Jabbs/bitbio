class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.string :science_type
      t.integer :user_id
      t.string :service_need

      t.timestamps
    end
    add_index :projects, :user_id
    add_index :projects, :science_type
    add_index :projects, :service_need
  end
end
