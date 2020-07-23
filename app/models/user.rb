class User < ApplicationRecord
  has_many :courses
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: ["member", "teacher", "admin"]
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
end
