class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :city
      t.string :state
      t.string :zip
      t.string :country
      t.float :latitude
      t.float :longitude
      t.belongs_to :locationable, polymorphic: true

      t.timestamps
    end
    add_index :locations, [:locationable_id, :locationable_type]
  end
end
