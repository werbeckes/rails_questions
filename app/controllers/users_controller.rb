class UsersController < ApplicationController
  before_action :authenticate, except: [:new, :create]

  def home
    @questions = current_user.questions.order(:created_at)
  end

  def new
    @user = User.new
  end

  def edit
    @time = current_user.send_time
    @days_of_week = [:sunday,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday]
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.set_defaults
      session[:user_id] = @user.id

      params[:user][:remember_me] ? exp = Time.now + 1.year : exp = Time.now + 1.hours
      session[:expires_on] = exp

      UserMailer.welcome_email(@user).deliver
      redirect_to home_path
    else
      render 'new'
    end
  end

  def update
    p user_update_params
    if current_user.update(user_update_params)
      redirect_to home_path
    else
      #TODO catch errors
      @days_of_week = [:sunday,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday]
      render 'edit'
    end
  end

  def answer
    @questions = current_user.questions.order(:created_at)
  end

  def add_answers
    date_hash = params[:answers].delete('date')
    date = find_answer_for_date(date_hash)

    params[:answers].each do |answer|
      question = Question.find_by_id(answer[0])
      if !question.answers.create(value: answer[1], answer_for: date)
        #TODO catch errors
        render 'answer'
      end
    end
    #TODO show message that answers were save successfully
    redirect_to home_path
  end

  def send_reminder
    #TODO if we are going to keep this make it visible to user that message was sent
    UserMailer.daily_reminder(current_user).deliver
    redirect_to :back
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :cell, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:send_time,:monday,:tuesday,:wednesday,:thursday,:friday,:saturday,:sunday)
    end

    def find_answer_for_date(date_hash)
      Date.civil(date_hash['date(1i)'].to_i,
                 date_hash['date(2i)'].to_i,
                 date_hash['date(3i)'].to_i)
    end
end
