class RemoveServiceTypeFromServices < ActiveRecord::Migration
  def up
    remove_column :services, :service_type
  end
  
  def down
    add_column :services, :service_type, :string
  end
end
