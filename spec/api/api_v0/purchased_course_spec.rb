require "rails_helper"
RSpec.feature "Purchased course", type: :request do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }
  let (:unpublic_course) { create(:course, name: "unpublic_course", user_id: teacher_user.id, public: false ) }
  let (:purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: teachers_course.id ) }
  describe "POST" do
    context "/api/v0/purchased_courses" do
      before do
        @course_id = teachers_course.id
      end

      context "create" do
        before do
          access_key = member_user.api_access_token
          post "/api/v0/purchased_courses", params: { access_key: access_key, course_id: @course_id}
          @result = JSON.parse(response.body)
        end
        it "should be successful" do
          expect(response.status).to eq(201)
          expect(@result["course_id"]).to eq(@course_id)
          expect(@result["user_id"]).to eq(member_user.id)
        end
      end

      context "when 購買自己的課程" do
        before do
          access_key = teacher_user.api_access_token
          post "/api/v0/purchased_courses", params: { access_key: access_key, course_id: @course_id}
          @result = JSON.parse(response.body)
        end
        it "should be create failed" do
          expect(response).to be_a_bad_request
          expect(response.status).to eq(400)
          expect(@result["message"]).to eq("400 Purchased course fail")
        end
      end

      context "when 購買已擁有且還未過期的課程" do
        before do
          purchased_course
          access_key = member_user.api_access_token
          post "/api/v0/purchased_courses", params: { access_key: access_key, course_id: @course_id}
          @result = JSON.parse(response.body)
        end
        it "should be create failed" do
          expect(response).to be_a_bad_request
          expect(response.status).to eq(400)
          expect(@result["message"]).to eq("400 Purchased course fail")
        end
      end

      context "when 購買未開放課程" do
        before do
          access_key = member_user.api_access_token
          post "/api/v0/purchased_courses", params: { access_key: access_key, course_id: unpublic_course.id}
          @result = JSON.parse(response.body)
        end
        it "should be create failed" do
          expect(response).to be_a_bad_request
          expect(response.status).to eq(400)
          expect(@result["message"]).to eq("400 Purchased course fail")
        end
      end
    end
  end
end
