class ConnectionRequestsController < ApplicationController
  before_filter :signed_in_user
  before_filter :verified_user
  
  def create
    @connection_receiver = User.find_by_id(params[:receiver_id])
    @connection_request = ConnectionRequest.new(receiver_id: @connection_receiver.id , sender_id: current_user.id)
    if @connection_request.save
      @connection_request.send_new_connection_request_email
      redirect_to @connection_receiver, notice: "Your connection request has been sent."
    else
      redirect_to @connection_receiver, alert: "You've already requested a connection from this member."
    end
  end
  
  def reply
    if @connection_request = ConnectionRequest.find_by_id(params[:id].to_s)
      @connection = Connection.new(connected_id: @connection_request.receiver_id, connecter_id: @connection_request.sender_id)
      if @connection.save
        redirect_to root_url, notice: "You are now connected with #{@connection.connected.first_name}!"
      else
        redirect_to root_url
      end
    else
      redirect_to root_url, alert: "Your connection could not be found."
    end
  end
  
  private
    
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
