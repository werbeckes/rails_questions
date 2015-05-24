class User < ActiveRecord::Base
  include BCrypt
  has_many :questions
  has_many :answers, through: :questions

  has_secure_password

  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :answers

end
