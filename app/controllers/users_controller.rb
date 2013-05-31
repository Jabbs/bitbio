class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :project_listings]
  before_filter :admin_user, only: [:researchers_index]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :correct_user_different_params, only: [:project_listings]
  before_filter :signed_in_user_go_to_dash, only: [:new, :create]
  
  def new
    @user = User.new
  end
  
  def project_listings
    @user = User.find(params[:user_id])
    @public_projects = @user.projects.where(active: true).where(visability: 'public')
    @private_projects = @user.projects.where(active: true).where(visability: 'private')
    @locked_projects = @user.projects.where(active: true).where(visability: 'locked')
    @inactive_projects = @user.projects.where(active: false)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    
    if @user.authenticate(params[:user][:password])
      if @user.update_attributes(params[:user])
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render action: "edit"
      end
    else
      redirect_to edit_user_url(@user), alert: 'Incorrect password'
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
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      @user.add_to_sign_in_attributes(request.remote_ip)
      @user.send_verification_email
      redirect_to @user, notice: "Welcome #{@user.first_name}! A verification email has been sent to your inbox."
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
    @projects = @user.projects
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to root_path, alert: "Your account has been cancelled."
  end
  
  def resend
    @user = User.find(params[:user_id])
    @user.send_verification_email
    redirect_to @user, notice: "A verification email has been sent. Please click on the link to verify your account.
                                        Check your spam folder if you are still having issues or contact our support team."
  end
  
  private
  
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
