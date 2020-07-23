class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: ["member", "teacher", "admin"]
  validates :name, presence: true, uniqueness: true
  validates :role, presence: true
end
