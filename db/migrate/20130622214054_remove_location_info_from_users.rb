class RemoveLocationInfoFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :address
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
    remove_column :users, :latitude
    remove_column :users, :longitude
  end

  def down
    add_column :users, :address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :latitude, :float
    add_column :users, :longitude, :float
  end
end
