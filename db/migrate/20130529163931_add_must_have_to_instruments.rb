class AddMustHaveToInstruments < ActiveRecord::Migration
  def change
    add_column :instruments, :must_have, :boolean, default: true
  end
end
