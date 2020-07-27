class PurchasedCourse < ApplicationRecord
  belongs_to :user
  belongs_to :course
  before_create :check_course_owner?, :check_course_public?

  def check_course_owner?
    if course.user.id == user.id
      errors.add(:user_id, I18n.t('errors.purchased_course.owner'))
    end
  end
  def check_course_public?
    unless course.public
      errors.add(:course_id, I18n.t('errors.purchased_course.public'))
    end
  end
end
