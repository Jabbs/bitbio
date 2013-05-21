class MessagesController < ApplicationController
  
  def create
    @project = Project.find_by_id(params[:message][:project_id])
    @message = Message.new(params[:message])
    @comments = @project.comments.order("created_at DESC")
    @comment = Comment.new
    if @message.save
      redirect_to root_path, notice: "Message sent"
    else
      render 'projects/show'
    end
  end
end
