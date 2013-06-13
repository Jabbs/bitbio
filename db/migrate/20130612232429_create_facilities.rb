class CreateFacilities < ActiveRecord::Migration
  def change
    create_table :facilities do |t|
      t.string :name

      t.timestamps
    end
    add_index :facilities, :name
  end
end
