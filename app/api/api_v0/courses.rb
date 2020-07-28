module ApiV0
  class Courses < Grape::API
    before { authenticate! }

    desc "Get all your courses"
    get "/courses" do
      courses = current_user.courses

      present courses, with: ApiV0::Entities::Course
    end
  end
end
