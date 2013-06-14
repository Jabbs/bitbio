class AddNoteToResource < ActiveRecord::Migration
  def change
    add_column :resources, :note, :text
    add_column :resources, :service_id, :integer
    add_column :resources, :quantity, :integer, default: 1
  end
end
