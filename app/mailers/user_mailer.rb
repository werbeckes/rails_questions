class UserMailer < ActionMailer::Base
  default from: "myDailyData1@gmail.com"

  def welcome_email(user)
    @user = user
    @url = 'https://github.com/werbeckes/rails_questions'
    @home = 'reddit.com'
    mail(to: @user.email, subject: "Welcome to MyDailyStats")
  end

  def daily_reminder(user)
    @user = user
    mail(to: @user.email, subject: "Don't forget to track your day!")
  end
end
