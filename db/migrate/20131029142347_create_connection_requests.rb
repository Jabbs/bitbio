class CreateConnectionRequests < ActiveRecord::Migration
  def change
    create_table :connection_requests do |t|
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false
      t.datetime :new_connection_request_email_sent_at

      t.timestamps
    end
    add_index :connection_requests, :sender_id
    add_index :connection_requests, :receiver_id
  end
end
