class UserMailer < ActionMailer::Base
  default from: "Bitbio <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  
  def new_message_email(message)
    @message = message
    @receiver = message.receiver
    @sender = message.sender
    mail(to: "#{@receiver.full_name} <#{@receiver.email}>", subject: "Bitbio - Message Alert")
  end
  
  def new_comment_email(comment)
    @user = comment.commentable.user
    @comment = comment
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "Bitbio - New Comment Alert")
  end
  
  def password_reset_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Bitbio - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your Bitbio Account")
  end
end
