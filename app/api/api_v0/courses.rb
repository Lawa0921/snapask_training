module ApiV0
  class Courses < Grape::API
    before { authenticate! }

    desc "Get all your courses"
    get "/courses" do
      current_user.courses
    end
  end
end
