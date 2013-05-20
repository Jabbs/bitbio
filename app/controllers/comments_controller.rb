class CommentsController < ApplicationController
  def create
    @comment = Comment.new(params[:comment])
    @project = Project.find(params[:comment][:project_id])
    @comments = @project.comments
    if @comment.save
      redirect_to project_path(@project), notice: 'Your comment has been posted'
    else
      render template: 'projects/show'
    end
  end
end
