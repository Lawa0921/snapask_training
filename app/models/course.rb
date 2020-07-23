class Course < ApplicationRecord
  belongs_to :user
  enum currency: ["TWD", "USD", "JPD", "CNY"]
  enum type_of_course: ["math", "english", "japanese", "chinese", "social", "science", "history", "other"]
  validates :name, presence: true
  validates :price, presence: true
  validates :currency, presence: true
  validates :type_of_course, presence: true
  validates :public, presence: true
  validates :valididy_period, presence: true
end
