class CommentsController < ApplicationController
  before_filter :load_commentable
  def create
    @comment = @commentable.comments.new(params[:comment])
    @comments = @commentable.comments.order("created_at ASC")
    
    if @comment.save
      @comment.send_new_comment_email unless @commentable.user == @comment.user
      redirect_to @commentable, notice: 'Your comment has been posted'
    else
      if @comment.commentable_type == "Project"
        @project = Project.find(params[:project_id])
        render template: 'projects/show'
      elsif @comment.commentable_type == "Blog"
        @blog = Blog.find(params[:blog_id])
        render template: 'blogs/show'
      elsif @comment.commentable_type == "Event"
        @event = Event.find(params[:event_id])
        render template: 'events/show'
      end
    end
  end
  
  private
  
    def load_commentable
      resource, id = request.path.split('/')[1, 2]
      @commentable = resource.singularize.classify.constantize.find(id)
    end
end
