class AddAccountTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :account_type, :string, default: "Researcher"
    add_index :users, :account_type
  end
end
