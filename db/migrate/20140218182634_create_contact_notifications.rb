class CreateContactNotifications < ActiveRecord::Migration
  def change
    create_table :contact_notifications do |t|
      t.integer :contact_id
      t.datetime :email_sent_at
      t.string :action

      t.timestamps
    end
    add_index :contact_notifications, :contact_id
  end
end
