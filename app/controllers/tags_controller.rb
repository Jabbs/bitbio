class TagsController < ApplicationController
  def index
    
  end
  
  def show
    if params[:tag] && Project.tagged_with(params[:tag])
      @projects = Project.tagged_with(params[:tag]).order("created_at DESC").paginate(page: params[:page], per_page: 9)
    else
      @projects = []
    end
  end
end
