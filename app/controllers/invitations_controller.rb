class InvitationsController < ApplicationController
  before_filter :signed_in_user
  before_filter :verified_user
  
  def new
    @invitation = Invitation.new
  end
  
  private
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
