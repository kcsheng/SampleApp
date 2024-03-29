module SessionsHelper
  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end
  # Remembers a user in a persistent session
  def remember(user)
    user.remember
    cookies.permanent.encrypted[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  # Defines the current user
  def current_user
    if (user_id = session[:user_id]) # when user logs in via login
      @current_user ||= User.find_by(id: user_id)
      # Same as @current_user = @current_user || User.find_by(id: session[:user.id])
    elsif (user_id = cookies.encrypted[:user_id]) # when user logs in via cookies
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns whether user has logged in
  def logged_in?
    !current_user.nil?
  end

  # Forgets a persistent session of a user
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out current user
  def log_out
    forget(current_user)
    reset_session # Cleaner than session.delete(:user_id)
    @current_user = nil
  end  
end
