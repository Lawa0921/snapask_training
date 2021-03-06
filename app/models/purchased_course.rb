class PurchasedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :add_course_data
  enum currency: ["TWD", "USD", "JPD", "CNY"]
  validate :check_course_owner?, :check_course_public?, :check_own_course_expirt?
  scope :unexpired, -> { where("expirt_date > ?", DateTime.now)}
  scope :select_course_type, -> (type) { joins(:course).where( "courses.type_of_course = ? " ,  Course.type_of_courses[type] ) }
  scope :select_unexpired_course, -> { where( "expirt_date > ?", DateTime.now ) }

  def check_course_owner?
    errors.add(:user_id, I18n.t('errors.purchased_course.owner')) if course.user.id == user.id
  end

  def check_course_public?
    errors.add(:course_id, I18n.t('errors.purchased_course.public')) unless course.public
  end

  def check_own_course_expirt?
    errors.add(:expirt_date, I18n.t('errors.purchased_course.expirt_date')) if self.user.purchased_courses.where("course_id = ? AND expirt_date > ?", self.course_id, DateTime.now).first.present?
  end

  def self.check_course_expirt_date?(course, user)
    where("course_id = ? AND  user_id = ? AND expirt_date > ?", course.id, user.id, DateTime.now).first.present?
  end

  def add_course_data
    self.expirt_date = course.valididy_period.days.after
    self.price = course.price
    self.currency = course.currency
  end
end
