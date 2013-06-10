class LikesController < ApplicationController
  before_filter :signed_in_user
  before_filter :verified_user
  before_filter :check_for_duplicate_likes, only: [:create]
  
  def index
    redirect_to root_path
  end
  
  def create
    @blog = Blog.find(params[:blog_id])
    @like = @blog.likes.build(user_id: current_user.id)
    if @like.save
      respond_to do |format|
        format.html { redirect_to @blog }
        format.js
      end
    end
  end
  
  private
    
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
    
    def check_for_duplicate_likes
      @blog = Blog.find(params[:blog_id])
      redirect_to @blog, notice: 'You have already promoted this.' if @blog.likes.where(user_id: current_user.id).any?
    end
  
end
