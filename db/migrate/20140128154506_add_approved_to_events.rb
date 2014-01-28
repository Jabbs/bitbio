class AddApprovedToEvents < ActiveRecord::Migration
  def up
    unless column_exists? :events, :approved
      add_column :events, :approved, :boolean, default: false
    end
  end
  
  def down
    remove_column :events, :approved
  end
end
