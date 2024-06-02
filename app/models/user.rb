class User < ApplicationRecord
  has_secure_password
  has_many :meal_plans

  validates :email, presence: true, uniqueness: true
end
