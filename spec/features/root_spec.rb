require "rails_helper"
RSpec.feature "Root", type: :feature do
  let(:teacher_user1) { create(:user, role: 1 ) }
  let(:teacher_user2) { create(:user, role: 1 ) }
  let(:teacher1s_course) { create(:course, user_id: teacher_user1.id ) }

  describe "When root" do
    before do
      teacher_user1
      teacher_user2
      teacher1s_course
    end

    context "when teacher1" do
      before do
        user_login(teacher_user1)
      end
      it "should be not see course" do
        expect(page).not_to have_content teacher1s_course.name
      end
    end

    context "when teacher2" do
      before do
        user_login(teacher_user2)
      end
      it "should be see course" do
        expect(page).to have_content teacher1s_course.name
      end
    end
  end
end
