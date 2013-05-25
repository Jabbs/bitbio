class AddNewMessageEmailSentAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :new_message_email_sent_at, :datetime
  end
end
