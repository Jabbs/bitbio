module SessionsHelper
  
  def sign_in(user)
    cookies[:auth_token] = user.auth_token
    self.current_user = user
  end
  
  def current_user=(user)
    @current_user = user
  end
  
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token])
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def admin_user?
    true if current_user && current_user.admin?
  end
  
  def signed_in_user
    unless current_user
      store_location
      redirect_to login_url, alert: "Please sign in first."
    end
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end
  
  def store_location
    session[:return_to] = request.url
  end
end
