class BlogsController < ApplicationController
  def show
    @blog = Blog.find(params[:id])
    if request.path != blog_path(@blog)
      redirect_to @blog, status: :moved_permanently
    end
    @blog.add_view_count unless current_user?(@blog.user)
  end
end
