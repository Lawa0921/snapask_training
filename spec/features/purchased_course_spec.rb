require "rails_helper"
RSpec.feature "Courses", type: :feature do
  let (:member_user) { create(:user, role: 0 ) }
  let (:expired_course) { create(:purchased_course, user_id: member_user.id ) }
  let (:purchased_course) { create(:purchased_course, user_id: member_user.id ) }
  describe "When index" do
    before do
      user_login(member_user)
    end
    context "只能看到未過期的紀錄" do
      before do
        Timecop.travel(Time.local(2000, 6, 14, 10, 0, 0))
        expired_course
        Timecop.return
        purchased_course
        visit root_path
        click_link I18n.t("users.purchased_courses")
      end
      it "should be have 1 purchased course" do
        expect(all('.main-card-link').count).to eq 1
      end
    end
  end
end
