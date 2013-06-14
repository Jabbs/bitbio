class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :kind

      t.timestamps
    end
    add_index :resources, :name
    add_index :resources, :kind
  end
end
