class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_username(params[:user][:username])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id

      params[:user][:remember_me] ? exp = Time.now + 1.year : exp = Time.now + 1.hours
      session[:expires_on] = exp

      redirect_to home_path
    else
      redirect_to login_path
    end
  end

  def destroy
    session.clear
    redirect_to login_path
  end
end
