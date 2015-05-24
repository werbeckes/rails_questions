class UsersController < ApplicationController

  def home
    @questions = current_user.questions.order(:created_at)
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

  def answer
    @questions = current_user.questions.order(:created_at)
  end

  def add_answers

    params[:answers].each do |answer|
      question = Question.find_by_id(answer[0])
      if !question.answers.create(value: answer[1])
        #TODO catch errors
        render 'answer'
      end
    end
    #TODO show message that answers were save successfully
    redirect_to home_path
  end

  private
    def user_params
      params.require(:user).permit(:username, :password, :email, :cell)
    end
end
