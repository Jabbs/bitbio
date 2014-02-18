class UserMailer < ActionMailer::Base
  default from: "BitBio <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  
  def new_message_email(message)
    @message = message
    @user = message.receiver
    @sender = message.sender
    if @user.subscribed?
      mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - Message Alert")
    end
  end
  
  def new_connection_request_email(connection_request)
    @connection_request = connection_request
    @user = connection_request.receiver
    @sender = connection_request.sender
    if @user.subscribed?
      mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - Connection Request")
    end
  end
  
  def new_comment_email(comment)
    @user = comment.commentable.user
    @comment = comment
    if @user.subscribed?
      mail(to: "#{@user.full_name} <#{@user.email}>", subject: "BitBio - New Comment Alert")
    end
  end
  
  def password_reset_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "BitBio - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your BitBio Account")
  end
  
  def welcome_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Welcome to BitBio - Science Community, Forum, and Resource")
  end
  
  def invitation_email(invitation)
    @invitation = invitation
    mail(to: "<#{@invitation.email}>", subject: "#{@invitation.user.full_name} has sent you an invitation to join BitBio!")
  end
  
  def newsletter_email(contact)
    @contact = contact
    if @contact.subscribed?
      unless @contact.contact_notifications.where(action: "newsletter1").any?
        mail(to: "#{contact.full_name} <#{contact.email}>", subject: "BitBio - Science Community, Forum, and Resource")
        @contact.contact_notifications.create! action: "newsletter1", email_sent_at: DateTime.now
      end
    end
  end
end
