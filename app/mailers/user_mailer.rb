class UserMailer < ActionMailer::Base
  default from: "bitBIO <#{ENV['GMAIL_USERNAME']}>"
  default content_type: "text/html"
  
  def password_reset_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "bitBIO - Password Reset")
  end
  
  def verification_email(user)
    @user = user
    mail(to: "#{user.first_name} #{user.last_name} <#{user.email}>", subject: "Verify your bitBIO Account")
  end
end
