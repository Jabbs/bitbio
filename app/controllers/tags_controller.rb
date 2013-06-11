class TagsController < ApplicationController
  def index_projects
  end
  
  def index_blogs
  end
  
  def show_projects
    if params[:tag] && Project.tagged_with(params[:tag])
      @projects = Project.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page], per_page: 9)
    else
      @projects = []
    end
  end
  
  def show_blogs
    if params[:tag] && Blog.tagged_with(params[:tag])
      @blogs = Blog.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page], per_page: 9)
    else
      @blogs = []
    end
  end
end
