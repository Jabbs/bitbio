class MoveAttrFromServicesToResources < ActiveRecord::Migration
  def up
    remove_column :services, :price
    remove_column :services, :unit_type
    add_column :resources, :price, :integer
    add_column :resources, :unit_type, :string
    add_column :resources, :currency_type, :string
  end

  def down
    add_column :services, :price, :integer
    add_column :services, :unit_type, :string
    remove_column :resources, :price
    remove_column :resources, :unit_type
    remove_column :resources, :currency_type
  end
end
