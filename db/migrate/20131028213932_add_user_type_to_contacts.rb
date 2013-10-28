class AddUserTypeToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :user_type, :string
  end
end
