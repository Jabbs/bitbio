class PasswordResetsController < ApplicationController
  
  def new
  end
  
  def create
    @forgot_pass_user = User.find_by_email(params[:email].to_s)
    if @forgot_pass_user
      @forgot_pass_user.send_password_reset
      redirect_to root_path, notice: "Email sent with password reset instructions."
    else
      redirect_to root_path, alert: "Email not found."
    end
  end
  
  def edit
    if User.find_by_password_reset_token(params[:id].to_s)
      @user = User.find_by_password_reset_token!(params[:id].to_s)
    else
      redirect_to root_path, alert: "User was not found. Please contact our support team for more details."
    end
  end
  
  def update
    @user = User.find_by_password_reset_token(params[:id].to_s)
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, alert: "Password reset has expired."
    elsif params[:user][:password].size < 6 || params[:user][:password_confirmation].size < 6
      @user.errors.add(:password, "must be at least 6 characters") if params[:user][:password].size < 6
      @user.errors.add(:password_confirmation, "must be at least 6 characters") if params[:user][:password_confirmation].size < 6
      render 'edit'
    elsif @user.update_attributes(params[:user])
      sign_in @user
      redirect_to root_path, notice: "Your new password has been updated!"
    else
      redirect_to edit_password_reset_path, alert: "Invalid password/confirmation combination."
    end
  end
end
