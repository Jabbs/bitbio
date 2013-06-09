class ProjectsController < ApplicationController
  before_filter :signed_in_user, except: [:index, :show]
  before_filter :verified_user, except: [:index, :show]
  before_filter :check_if_private_or_locked_or_inactive, only: [:show]
  before_filter :correct_user, only: [:edit, :update, :destroy]
  
  def index
    @projects = Project.where(searchable: true).order("created_at DESC").search(params[:any], params[:na], params[:eur], params[:asia], params[:aus], params[:science], params[:tag]).paginate(page: params[:page], per_page: 9)
    @blogs = Blog.featured
    @featured_users = User.featured
  end
  
  def new
    @project = Project.new
  end
  
  def tags
    respond_to do |f|
      f.html { redirect_to '/' }
      f.json { render json: Project::TAGS }
    end
  end
  
  def show
    @project = Project.find(params[:id])
    @project.add_view_count unless current_user?(@project.user)
    @comments = @project.comments.order("created_at ASC")
    @comment = @project.comments.new
    @commentable = @project
    if request.path != project_path(@project)
      redirect_to @project, status: :moved_permanently
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The project you attempted to view is no longer available."
  end
  
  def edit
    @project = Project.find(params[:id])
  end
  
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      create_tags
      @project.save!
      check_if_searchable
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render action: "edit"
    end
  end
  
  def create
    @project = Project.new(params[:project])
    @project.user = current_user
    create_tags
    if @project.save
      create_bitly_url(project_url(@project)) if Rails.env.production? && ENV['STAGING'].nil?
      check_if_searchable
      redirect_to @project, notice: "Your project listing has now been activated! You will receive email notifications
      when your project receives comments or messages from another bitBIO member."
    else
      render 'new'
    end
  end
  
  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    
    redirect_to user_project_listings_path(current_user), alert: "Your project has been removed."
  end
  
  private
    
    def create_bitly_url(long_url)
      bitly = Bitly.client
      u = bitly.shorten(long_url)
      @project.bitly_url = u
      @project.save!
    end
    
    def create_tags
      tag_list = params["hidden-project"]["tag_list"].split(',')
      tag_list.each do |tag|
        unless tag == 'bitbio'
          if Tag.find_by_name(tag)
            t = Tag.find_by_name(tag)
          else
            t = Tag.create!(name: tag)
          end
          @project.taggings.build(tag_id: t.id)
        end
      end
    end
    
    def check_if_searchable
      @project.visability == 'locked' ? @project.searchable = false : @project.searchable = true
      @project.save
    end
    
    def check_if_private_or_locked_or_inactive
      @project = Project.find(params[:id])
      if @project.inactive?
        unless current_user && current_user?(@project.user)
          redirect_to root_path, alert: "The project you tried to view is no longer active." unless current_user && current_user.admin?
        end
      elsif @project.visability == 'private'
        unless current_user && current_user.verified
          redirect_to root_path, alert: "This project is only viewable to verified bitBIO members. Please sign up or log in to view this project."
        end
      elsif @project.visability == 'locked'
        unless current_user && current_user.verified && current_user?(@project.user)
          redirect_to root_path, alert: "This project is has been locked by the owner and is not currently viewable." unless current_user && current_user.admin?
        end
      end
    end
  
    def verified_user
      redirect_to current_user, alert: 'Please verify your account first.' unless current_user.verified
    end
    
    def correct_user
      @project = Project.find(params[:id])
      redirect_to root_path unless current_user?(@project.user) || current_user.admin?
    end
    
    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
end
