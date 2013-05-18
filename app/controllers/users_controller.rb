class UsersController < ApplicationController
  def new
    @user = User.new
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
    @users = User.where(account_type: "Researcher").order("last_name ASC")
    render template: "users/index"
  end
  
  def providers_index
    @users = User.where(account_type: "Provider").order("last_name ASC")
    render template: "users/index"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user, notice: "Welcome #{@user.first_name}!"
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
end
