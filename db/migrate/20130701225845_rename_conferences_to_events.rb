class RenameConferencesToEvents < ActiveRecord::Migration
  def up
    rename_table :conferences, :events
  end

  def down
    rename_table :events, :conferences
  end
end
