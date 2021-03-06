require "rails_helper"
RSpec.feature "Purchased course", type: :request do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }
  let (:unpublic_course) { create(:course, name: "unpublic_course", user_id: teacher_user.id, public: false ) }
  let (:purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: teachers_course.id ) }
  let (:purchased_courses) { create_list(:purchased_course, 10, user_id: member_user.id) }
  let (:expired_course) { create(:purchased_course, user_id: member_user.id)}
  let (:math_course) { create(:course, type_of_course: "math", user_id: teacher_user.id) }
  let (:english_course) { create(:course, type_of_course: "english", user_id: teacher_user.id)}
  let (:math_purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: math_course.id) }
  let (:english_purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: english_course.id) }
  describe "POST /api/v0/purchased_courses" do
    before do
      @course_id = teachers_course.id
    end

    context "create successful" do
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

    context "when 沒有傳入 course_id" do
      before do
        access_key = member_user.api_access_token
        post "/api/v0/purchased_courses", params: { access_key: access_key}
        @result = JSON.parse(response.body)
      end
      it "should be create failed" do
        expect(response).to be_a_bad_request
        expect(response.status).to eq(400)
        expect(@result["message"]).to eq("400 Purchased course fail")
      end
    end

    context "when 沒有傳入 access_key" do
      before do
        post "/api/v0/purchased_courses", params: { course_id: @course_id}
        @result = JSON.parse(response.body)
      end
      it "should be raise AuthorizationError" do
        expect(response.status).to eq(401)
        expect(@result["error"]["message"]).to eq('Authorization failed')
      end
    end
  end

  describe "GET /api/v0/purchased_courses" do

    context "search successful" do
      before do
        purchased_courses
        access_key = member_user.api_access_token
        get "/api/v0/purchased_courses", params: { access_key: access_key }
        @result = JSON.parse(response.body)
      end
      it "should return 10 courses" do
        expect(response.status).to eq(200)
        expect(@result.length).to eq(10)
      end
    end

    context "Search successful with type_of_course" do
      before do
        math_purchased_course
        english_purchased_course
        access_key = member_user.api_access_token
        get "/api/v0/purchased_courses", params: { access_key: access_key, type_of_course: "math" }
        @result = JSON.parse(response.body)
      end
      it "should return math type courses" do
        expect(response.status).to eq(200)
        expect(@result.length).to eq(1)
        expect(response.body).not_to include("english")
      end
    end

    context "Search successful with unexpired" do
      before do
        Timecop.travel(Time.local(2000, 6, 14, 10, 0, 0))
        expired_course
        Timecop.return
        access_key = member_user.api_access_token
        get "/api/v0/purchased_courses", params: { access_key: access_key, unexpired: true }
        @result = JSON.parse(response.body)
      end
      it "should return 0 courses" do
        expect(response.status).to eq(200)
        expect(@result.length).to eq(0)
      end
    end

    context "Search successful with unexpired and type_of_course" do
      before do
        Timecop.travel(Time.local(2000, 6, 14, 10, 0, 0))
        expired_course
        Timecop.return
        math_purchased_course
        english_purchased_course
        access_key = member_user.api_access_token
        get "/api/v0/purchased_courses", params: { access_key: access_key, type_of_course: "math", unexpired: true }
        @result = JSON.parse(response.body)
      end
      it "should return comply with courses" do
        expect(response.status).to eq(200)
        expect(@result.length).to eq(1)
        expect(response.body).not_to include("english")
      end
    end

    context "when 沒有傳入 access_key" do
      before do
        get "/api/v0/purchased_courses", params: { type_of_course: "math", unexpired: true }
        @result = JSON.parse(response.body)
      end
      it "should be raise AuthorizationError" do
        expect(response.status).to eq(401)
        expect(@result["error"]["message"]).to eq('Authorization failed')
      end
    end

  end
end
