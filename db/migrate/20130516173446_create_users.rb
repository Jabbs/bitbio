class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :account_type
      t.string :organization
      t.string :phone
      t.text :description
      t.string :password_digest
      t.string :auth_token
      t.string   :password_reset_token
      t.datetime :password_reset_sent_at
      t.boolean :admin, default: false

      t.timestamps
    end
    add_index :users, :id
    add_index :users, :last_name
    add_index :users, :email
    add_index :users, :account_type
  end
end
