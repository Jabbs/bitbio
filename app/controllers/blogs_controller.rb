class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    @blog.add_view_count unless current_user?(@blog.user)
    @comment = @blog.comments.new
    @comments = @blog.comments.order("created_at ASC")
    @commentable = @blog
    if request.path != blog_path(@blog)
      redirect_to @blog, status: :moved_permanently
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The blog you attempted to view is no longer available."
  end
  
  def new
    @blog = current_user.blogs.build
  end
  
  def create
     @blog = current_user.blogs.build(params[:blog])
    # create_tags
    if @blog.save
      # create_bitly_url(blog_url(@blog)) if Rails.env.production? && ENV['STAGING'].nil?
      redirect_to @blog, notice: "Your blog entry has been created!"
    else
      render 'new'
    end
  end
  
  def edit
    @blog = Blog.find(params[:id])
  end
  
  def update
    @blog = Blog.find(params[:id])
    if @blog.update_attributes(params[:blog])
      # create_tags
      @blog.save!
      redirect_to @blog, notice: 'Blog was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  private
    
    def create_bitly_url(long_url)
      bitly = Bitly.client
      u = bitly.shorten(long_url)
      @blog.bitly_url = u
      @blog.save!
    end
end
