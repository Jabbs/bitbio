class ChangeContactField < ActiveRecord::Migration
  def up
    change_column :contacts, :user_type, :string, default: "Researcher"
  end

  def down
    change_column :contacts, :user_type, :string, default: "Other"
  end
end
