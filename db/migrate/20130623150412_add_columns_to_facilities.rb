class AddColumnsToFacilities < ActiveRecord::Migration
  def change
    add_column :facilities, :website, :string
    add_column :facilities, :email, :string
    add_column :facilities, :phone, :string
  end
end
