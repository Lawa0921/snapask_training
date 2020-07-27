class PurchasedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :check_course_owner?

  def check_course_owner?
    if course.user.id == user.id
      errors.add(:course, message: I18n.t('errors.purchased_course.owner'))
    end
  end
  def check_course_public?
    unless course.public
      errors.add(:course, message: I18n.t('errors.purchased_course.public'))
    end
  end
end
