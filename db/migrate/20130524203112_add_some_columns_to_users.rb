class AddSomeColumnsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :verified, :boolean
    add_column :users, :verification_token, :string
    add_column :users, :verification_sent_at, :datetime
    add_column :users, :sign_in_count, :integer, :default => 0
    add_column :users, :last_sign_in_at, :datetime
    add_column :users, :last_sign_in_ip, :string
  end
end
