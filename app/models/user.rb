class User < ApplicationRecord
  has_many :courses
  has_many :purchased_courses
  has_secure_token :api_access_token
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: ["member", "teacher", "admin"]
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
  validates :api_access_token, uniqueness: true
end
