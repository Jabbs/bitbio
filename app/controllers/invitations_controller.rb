class InvitationsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :verified_user, except: [:index, :show]
  
  def new
    @invitation = Invitation.new
  end
  
  private
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
