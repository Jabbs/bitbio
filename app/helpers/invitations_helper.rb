module InvitationsHelper
  
  def invite_token_present?
    if params[:invite_token] && User.find_by_invite_token(params[:invite_token])
      true
    else
      false
    end
  end
end
