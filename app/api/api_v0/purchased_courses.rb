module ApiV0
  class PurchasedCourses < Grape::API
    desc "Create new purchased course"
    post "purchased_courses" do 
      params do
        requires :course_id, type: Integer, desc: "Want to buy course"
        requires :access_key, type: String, desc: "User auth token"
      end
      raise PurchasedCourseError if params[:course_id].blank?
      purchased_course = current_user.purchased_courses.new(course_id: params[:course_id])
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
      purchased_records = set_purchased_courses(current_user.purchased_courses, params)
      present purchased_records, with: ApiV0::Entities::PurchasedCourse
    end
  end
end
