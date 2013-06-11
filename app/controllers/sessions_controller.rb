class SessionsController < ApplicationController
  def new
  end

  def create
    @session_user = User.find_by_email(params[:email].to_s.downcase)
    if @session_user && @session_user.authenticate(params[:password].to_s)
      sign_in @session_user
      @session_user.add_to_sign_in_attributes(request.remote_ip)
      redirect_back_or root_path
    else
      @blogs = Blog.featured
      @featured_users = User.featured
      @session_user = User.new
      @session_user.errors.add(:email, "Invalid email/password combination")
      render template: "projects/home"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_path, notice: 'You are now signed out'
  end
end
