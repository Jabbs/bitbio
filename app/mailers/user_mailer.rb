class UserMailer < ActionMailer::Base
  default from: "bitBIO <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  
  def new_message_email(message)
    @message = message
    @receiver = message.receiver
    @sender = message.sender
    mail(to: "#{@receiver.full_name} <#{@receiver.email}>", subject: "bitBIO - Message Alert")
  end
  
  def new_comment_email(comment)
    @user = comment.project.user
    @comment = comment
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "bitBIO - New Comment Alert")
  end
  
  def password_reset_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "bitBIO - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your bitBIO Account")
  end
end
