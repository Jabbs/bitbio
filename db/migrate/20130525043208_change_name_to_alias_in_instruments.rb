class ChangeNameToAliasInInstruments < ActiveRecord::Migration
  def change
    rename_column :instruments, :name, :alias
  end
end
