require "rails_helper"
RSpec.feature "Purchased course", type: :request do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }
  let (:courses) {create_list(:course, 10, user_id: teacher_user.id)}
  let (:purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: teachers_course.id) }
  describe "POST" do
    context "/api/v0/purchased_courses" do
      before do
        teachers_course
        @course_id = teachers_course.id
        @access_key = member_user.api_access_token
      end
      it "should be created successfully" do
        post "/api/v0/purchased_courses", params: { access_key: @access_key, course_id: @course_id}
        result = JSON.parse(response.body)
        expect(response.status).to eq(201)
        expect(result["course_id"]).to eq(@course_id)
        expect(result["user_id"]).to eq(member_user.id)
      end
    end
  end
end
