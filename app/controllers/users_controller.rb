class UsersController < ApplicationController

  def home
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path
    else
      render 'form'
    end
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email, :cell)
    end
end