class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if user &.authenticate(params[:session][:password]) # user && user.authenticate
      reset_session # for security
      log_in user
      redirect_to user # same as user_url(user)
    else
      flash.now[:danger] = 'Invalid email/password combination!'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
