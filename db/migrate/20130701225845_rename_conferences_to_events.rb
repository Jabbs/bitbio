class RenameEventsToEvents < ActiveRecord::Migration
  def up
    rename_table :events, :events
  end

  def down
    rename_table :events, :events
  end
end
