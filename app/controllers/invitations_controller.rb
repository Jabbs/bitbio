class InvitationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :verified_user
  
  def new
    @invitation = Invitation.new
  end
  
  def index
    redirect_to root_path
  end
  
  def create
    @invitation = Invitation.new(params[:invitation])
    @invitation.user_id = current_user.id
    @email_group = params[:email_group]
    
    # error handling for email_group (since its not a model column)    
    if @email_group.split(/\s*,\s*/).count > 20
      @invitation.errors.add(:email_group, "has a 20 email limit")
      render 'new'
      return
    elsif @email_group.blank? || @email_group.split(/\s*,\s*/).count == 0
      @invitation.errors.add(:email_group, "must contain at least one email")
      render 'new'
      return
    end
    
    @email_group.split(/\s*,\s*/).each do |email|
      invitation = Invitation.new(email: email.strip, message: params[:invitation][:message])
      invitation.user_id = current_user.id
      if invitation.save
        UserMailer.invitation_email(invitation).deliver
      end
    end
    redirect_to new_invitation_path, notice: "Your invitations have been sent!"
  end
  
  private
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
