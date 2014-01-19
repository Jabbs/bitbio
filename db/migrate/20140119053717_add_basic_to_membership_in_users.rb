class AddBasicToMembershipInUsers < ActiveRecord::Migration
  def change
    change_column :users, :membership, :string, :default => "basic"
  end
end
