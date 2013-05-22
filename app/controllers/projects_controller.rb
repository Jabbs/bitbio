class ProjectsController < ApplicationController
  def index
    @projects = Project.order("start_date ASC").search(params[:keyword], params[:start_date], params[:end_date], params[:country], params[:science]).paginate(page: params[:page], per_page: 9)
  end
  
  def new
    @project = Project.new
  end
  
  def show
    @project = Project.find(params[:id])
    @comments = @project.comments.order("created_at ASC")
    @comment = Comment.new
    if request.path != project_path(@project)
      redirect_to @project, status: :moved_permanently
    end
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(params[:project])
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def create
    @project = Project.new(params[:project])
    @project.user = current_user
    if @project.save
      redirect_to @project, notice: "Your project has been created!"
    else
      render 'new'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    
    redirect_to root_path, alert: "Your project has been removed."
  end
end
