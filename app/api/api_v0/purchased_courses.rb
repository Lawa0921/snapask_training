module ApiV0
  class PurchasedCourses < Grape::API
    desc "Create new purchased course"
    params do
      requires :course_id, type: Integer
      requires :access_key, type: String
    end
    post "purchased_courses" do
      purchased_course = current_user.purchased_courses.new(declared(params, include_missing: false).except(:access_key))
      if purchased_course.save
        present purchased_course
      else
        raise PurchasedCourseError
      end
    end
  end
end
