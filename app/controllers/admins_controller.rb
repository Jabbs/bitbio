class AdminsController < ApplicationController
  before_filter :signed_in_user
  before_filter :admin_user
  
  def admin
    if params[:user_order] == "id"
      @users = User.order("id ASC").paginate(page: params[:page], per_page: 50)
    elsif params[:user_order] == "created_at"
      @users = User.order("created_at DESC").paginate(page: params[:page], per_page: 50)
    elsif params[:user_order] == "name"
      @users = User.order("last_name ASC").paginate(page: params[:page], per_page: 50)
    elsif params[:user_order] == "email"
      @users = User.order("email ASC").paginate(page: params[:page], per_page: 50)
    elsif params[:user_order] == "country"
      @users = User.order("country ASC").paginate(page: params[:page], per_page: 50)
    else
      @users = User.order("created_at DESC").paginate(page: params[:page], per_page: 50)
    end
    
    
    
    
    @projects = Project.order("created_at DESC").paginate(page: params[:page], per_page: 50)
    @blogs = Blog.order("created_at DESC").paginate(page: params[:page], per_page: 50)
    @events = Event.order("created_at DESC").paginate(page: params[:page], per_page: 50)
    @facilities = Facility.order("created_at DESC").paginate(page: params[:page], per_page: 50)
  end
  
  private
  
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
end
