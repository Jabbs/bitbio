class UserMailer < ActionMailer::Base
  default from: "BitBio <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  
  def new_message_email(message)
    @message = message
    @user = message.receiver
    @sender = message.sender
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - Message Alert")
  end
  
  def new_connection_request_email(connection_request)
    @connection_request = connection_request
    @user = connection_request.receiver
    @sender = connection_request.sender
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - Connection Request")
  end
  
  def new_comment_email(comment)
    @user = comment.commentable.user
    @comment = comment
    mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - New Comment Alert")
  end
  
  def password_reset_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "BitBio - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your BitBio Account")
  end
  
  def invitation_email(invitation)
    @invitation = invitation
    @user = @invitation.user
    mail(to: "<#{@invitation.email}>", subject: "#{@user.full_name} has sent you an invitation to join BitBio!")
  end
end
