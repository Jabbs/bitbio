class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    if request.path != blog_path(@blog)
      redirect_to @blog, status: :moved_permanently
    end
    @blog.add_view_count unless current_user?(@blog.user)
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The blog you attempted to view is no longer available."
  end
end
