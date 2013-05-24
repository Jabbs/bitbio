class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email].to_s.downcase)
    if user && user.authenticate(params[:password].to_s)
      sign_in user
      user.add_to_sign_in_attributes(request.remote_ip)
      redirect_back_or root_path
    else
      redirect_to login_path, alert: "Invalid email/password combination"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, notice: 'You are now signed out'
  end
end
