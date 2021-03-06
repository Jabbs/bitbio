class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :project_listings, :all_connections, :settings]
  before_filter :admin_user, only: [:researchers_index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :correct_user_different_params, only: [:project_listings, :all_connections, :settings]
  before_filter :signed_in_user_go_to_dash, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def index
    redirect_to root_path
  end
  
  def settings
    @user = User.find(params[:user_id])
  end
  
  def project_listings
    @user = User.find(params[:user_id])
    @public_projects = @user.projects.where(active: true).where(visability: 'public').paginate(page: params[:page], per_page: 6)
    @private_projects = @user.projects.where(active: true).where(visability: 'private').paginate(page: params[:page], per_page: 6)
    @locked_projects = @user.projects.where(active: true).where(visability: 'locked').paginate(page: params[:page], per_page: 6)
    @inactive_projects = @user.projects.where(active: false).paginate(page: params[:page], per_page: 6)
  end
  
  def service_listings
    @user = User.find(params[:user_id])
    @public_services = @user.services.where(active: true).where(visability: 'public').paginate(page: params[:page], per_page: 6)
    @private_services = @user.services.where(active: true).where(visability: 'private').paginate(page: params[:page], per_page: 6)
    @locked_services = @user.services.where(active: true).where(visability: 'locked').paginate(page: params[:page], per_page: 6)
    @inactive_services = @user.services.where(active: false)
  end
  
  def edit
    @user = User.find(params[:id])
    @user.attachments.build
    @number_of_connections = @user.number_of_connections
    @connection_users = @user.connection_users_limit_nine
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      @user.attachments.order('created_at DESC').last.destroy if params[:user][:_destroy] == '1'
      redirect_to @user, notice: 'Your profile has been successfully updated.'
    else
      render "edit"
    end
  end
  
  def researchers_index
    @users = User.where(account_type: "Researcher").order("last_name ASC").paginate(page: params[:page], per_page: 9)
    render template: "users/index"
  end
  
  def providers_index
    @users = User.where(account_type: "Provider").order("last_name ASC").paginate(page: params[:page], per_page: 9)
    render template: "users/index"
  end
  
  def create
    @signup_user = User.new(params[:user])
    if @signup_user.save
      add_referrer
      create_facility
      sign_in @signup_user
      @signup_user.add_to_sign_in_attributes(request.remote_ip)
      @signup_user.send_verification_email
      redirect_to @signup_user, notice: "Welcome #{@signup_user.first_name}! A verification email has been sent to your inbox."
    else
      @blogs = Blog.featured
      @featured_users = User.featured
      @events = Event.featured
      render template: "projects/home"
    end
  end
  
  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    @number_of_connections = @user.number_of_connections
    @connection_users = @user.connection_users_limit_nine
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to root_path, alert: "The member you attempted to view is no longer available."
  end
  
  def all_connections
    @user = User.find(params[:user_id])
    @all_connections = @user.all_connection_users.paginate(page: params[:page], per_page: 12)
  end
  
  # def destroy
  #   @user = User.find(params[:id])
  #   @user.destroy
  #   
  #   redirect_to root_path, alert: "Your account has been cancelled."
  # end
  
  def resend
    @user = User.find(params[:user_id])
    @user.send_verification_email
    redirect_to @user, notice: "A verification email has been sent. Please click on the link to verify your account.
                                        Check your spam folder if you are still having issues or contact our support team."
  end
  
  private
  
    def add_referrer
      if User.find_by_invite_token(session[:invite_token])
        @signup_user.referrer_id = User.find_by_invite_token(session[:invite_token]).id
      end
    end
  
    def create_facility
      if facility = Facility.find_by_name(@signup_user.organization)
      else
        facility = Facility.new(name: @signup_user.organization)
        facility.build_location(country:  @signup_user.country, display_on_map: false)
        facility.save
      end
      @signup_user.update_attribute(:facility_id, facility.id)
      @signup_user.save
    end
    
    def admin_user
      redirect_to(root_path) unless current_user && current_user.admin?
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def correct_user_different_params
      @user = User.find(params[:user_id])
      redirect_to(root_path) unless current_user?(@user) || current_user.admin?
    end
    
    def signed_in_user_go_to_dash
      if current_user
        redirect_to root_path
      end
    end
end
