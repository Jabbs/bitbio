class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.string :name
      t.integer :facility_id

      t.timestamps
    end
    add_index :labs, :facility_id
    add_index :labs, :name
  end
end
