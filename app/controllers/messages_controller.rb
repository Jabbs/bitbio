class MessagesController < ApplicationController
  before_filter :signed_in_user
  before_filter :correct_user, only: [:index]
  before_filter :verified_user
  before_filter :sender_or_receiver, only: [:show]
  
  def index
    @sent_messages = current_user.sent_messages.order("created_at DESC").paginate(page: params[:page], per_page: 20)
    @received_messages = current_user.received_messages.order("created_at DESC").paginate(page: params[:page], per_page: 20)
    @contacts = current_user.all_connection_users
    @messages = []
    params[:sent] == "true" ? @messages = @sent_messages : @messages = @received_messages
  end
  
  def show
    @message = Message.find(params[:id])
    @message.view_message if current_user?(@message.receiver)
  end
  
  def create
    @project = Project.find_by_id(params[:message][:project_id])
    @message = Message.new(params[:message])
    @comments = @project.comments.order("created_at DESC") if @project
    @comment = Comment.new
    if @message.save
      @message.send_new_message_email
      redirect_to user_messages_path(current_user, sent: true), notice: "Your message has been sent to #{@message.receiver.full_name}"
    else
      if @project
        @comments = @project.comments.order("created_at ASC")
        @comment = @project.comments.new
        @commentable = @project
        render 'projects/show'
      else
        redirect_to user_messages_path(current_user), alert: "Message not sent. Please include a subject and body."
      end
    end
  end
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
    
    def correct_user
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def sender_or_receiver
      @message = Message.find(params[:id])
      redirect_to(root_path) unless current_user?(@message.sender) || current_user?(@message.receiver) || current_user.admin?
    end
    
    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
    
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
end
