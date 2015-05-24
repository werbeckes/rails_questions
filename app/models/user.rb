class User < ActiveRecord::Base
  include BCrypt
  has_many :questions
  has_many :answers, through: :questions

  has_secure_password

end
