module ApiV0
  class PurchasedCourses < Grape::API
    desc "Create new purchased course"
    params do
      requires :course_id, type: Integer, desc: "Want to buy course"
      requires :access_key, type: String, desc: "User auth token"
    end
    post "purchased_courses" do 
      purchased_course = current_user.purchased_courses.new(declared(params, include_missing: false).except(:access_key))
      if purchased_course.save
        present purchased_course
      else
        raise PurchasedCourseError
      end
    end

    desc "Get purchased courses"
    get "purchased_courses" do
      params do
        requires :access_key, type: String, desc: "User auth token"
        optional :type_of_course, type: String, desc: "What course type do you want to find"
        optional :unexpired, type: Boolean, desc: "True or false"
      end
      purchased_courses = current_user.purchased_courses
      present purchased_courses, with: ApiV0::Entities::PurchasedCourse
      # courses = purchased_courses.map(&:course)
      # putchased_courses.where() if :type_of_course.present?

    end
  end
end
