FactoryBot.define do
  factory :purchased_course do
    user
    course
    expirt_date { DateTime.now + course.valididy_period.days }
  end
end
