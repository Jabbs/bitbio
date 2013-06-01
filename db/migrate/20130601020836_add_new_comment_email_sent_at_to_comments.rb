class AddNewCommentEmailSentAtToComments < ActiveRecord::Migration
  def change
    add_column :comments, :new_comment_email_sent_at, :datetime
  end
end
