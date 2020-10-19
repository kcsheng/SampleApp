module SessionsHelper
  # logs in the given user
  def log_in(user)
    session[:user_id] = user.id
  end
  # Defines the current user
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      # Same as @current_user = @current_user || User.find_by(id: session[:user.id])
    end
  end
  # Returns whether user has logged in
  def logged_in?
    !current_user.nil?
  end
  # Logs out current user
  def log_out
    reset_session # Cleaner than session.delete(:user_id)
    @current_user = nil
  end  
end
