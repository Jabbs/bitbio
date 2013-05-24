class CreateInstruments < ActiveRecord::Migration
  def change
    create_table :instruments do |t|
      t.string :name
      t.integer :project_id

      t.timestamps
    end
    add_index :instruments, :project_id
    add_index :instruments, :name
  end
end
