require "rails_helper"
RSpec.feature "Course", type: :request do
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:courses) { create_list(:course, 10, user_id: teacher_user.id )}
  describe "GET /api/v0/courses" do
    before do
      @access_key = teacher_user.api_access_token
      courses
    end

    context "When successful" do
      before do
        get "/api/v0/courses", params: { access_key: @access_key }
        @result = JSON.parse(response.body)
      end
      it "should be return 10 course" do
        expect(@result.length).to eq 10
        expect(response.status).to eq 200
      end
    end

    context "When unfilled access" do
      before do
        get "/api/v0/courses"
        @result = JSON.parse(response.body)
      end
      it "should be raise AuthorizationError" do
        expect(response.status).to eq 401
        expect(@result["error"]["message"]).to eq 'Authorization failed'
      end
    end

  end
end
