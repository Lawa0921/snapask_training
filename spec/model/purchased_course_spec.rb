require "rails_helper"
RSpec.feature "Purchased course", type: :model do
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:member_user) { create(:user, role: 0 ) }
  let (:course) { create(:course, user_id: teacher_user.id) }
  let (:unpublic_course) { create(:course, user_id: teacher_user.id, public: false) }
  let (:success_purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: course.id) }
  describe "model validation" do
    context "可以正常建立" do
      it "when 正常填入" do
        record = PurchasedCourse.new(user_id: member_user.id, course_id: course.id)
        expect(record.save).to eq true 
      end
    end
    context "when 建立失敗" do
      context "嘗試購買自己的課程" do
        it "should 失敗" do
          @owner_fail_purchased_course = PurchasedCourse.new(user_id: teacher_user.id, course_id: course.id)
          expect(@owner_fail_purchased_course).not_to be_valid
        end
      end
      context "嘗試購買未公開的課程" do
        it "should 失敗" do
          @public_fail_purchased_course = PurchasedCourse.new(user_id: member_user.id, course_id: unpublic_course.id)
          expect(@public_fail_purchased_course).not_to be_valid
        end
      end
    end
  end
end
