module SessionsHelper
  
  def sign_in(user)
    cookies[:auth_token] = user.auth_token
  end
  
  def current_user
    if cookies[:auth_token]
      if User.find_by_auth_token(cookies[:auth_token])
        user = User.find_by_auth_token(cookies[:auth_token])
      end
      user
    end
  end
  
  def current_user?(user)
    user == current_user
  end
  
  def signed_in_user
    unless current_user
      store_location
      redirect_to login_url, notice: "Please sign in."
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
