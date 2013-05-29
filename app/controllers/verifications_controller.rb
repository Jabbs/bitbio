class VerificationsController < ApplicationController
  
  def show
    if User.find_by_verification_token(params[:id].to_s)
      @user = User.find_by_verification_token(params[:id].to_s)
      @user.update_attribute(:verified, true)
      sign_in @user unless current_user
      redirect_to root_path, notice: "Your account has been verified."
    else
      redirect_to root_path, notice: "There was a problem verifying your account. Please contact support@bitbio.org 
                                     for more details."
    end
  end
end
