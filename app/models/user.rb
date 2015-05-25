class User < ActiveRecord::Base
  include BCrypt
  has_many :questions
  has_many :answers, through: :questions

  has_secure_password

  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :answers

  validates :password, confirmation: true
  # validates :password_confirmation, presence: true

  def self.send_daily_emails
    @users = find_users_that_want_emails_now
  end

  def set_defaults
    self.update(
      send_time: Time.new(2000,1,1,21),
      sunday: true,
      monday: true,
      tuesday: true,
      wednesday: true,
      thursday: true,
      friday: true,
      saturday: true)
  end

  def find_users_that_want_emails_now
    today = Time.now
    time = today.floor(15.minutes)

    case today.wday
    when 0
      User.where(sunday: true).where('send_time = ?', time)

    end
  end

  def floor(seconds = 60)
    Time.at((self.to_f / seconds).floor * seconds)
  end

end
