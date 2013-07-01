class AddResourceTypeToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :resource_type, :string
    add_index :instruments, :resource_type
  end
end
