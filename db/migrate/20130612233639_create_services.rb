class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.string :service_type
      t.integer :price
      t.string :unit_type
      t.integer :user_id

      t.timestamps
    end
    add_index :services, :name
    add_index :services, :service_type
    add_index :services, :unit_type
    add_index :services, :price
    add_index :services, :user_id
  end
end
