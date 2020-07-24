class Course < ApplicationRecord
  belongs_to :user
  enum currency: ["TWD", "USD", "JPD", "CNY"]
  enum type_of_course: ["math", "english", "japanese", "chinese", "social", "science", "history", "other"]
  validates :name, :price, :currency, :type_of_course, :public, :valididy_period, presence: true
  scope :open_public, -> { where( public: true ) }
end
