require "rails_helper"
RSpec.feature "Carts", type: :feature do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }
  let (:courses) {create_list(:course, 10, user_id: teacher_user.id)}

  describe "When add course to cart" do
    before do
      user_login(member_user)
    end
    context "when try to add" do
      before do
        teachers_course
        visit root_path
        find(:css, ".main-card-link:first-child").click
        click_link I18n.t("add_to_cart")
      end
      it "should successfully" do
        expect(page).to have_content "#{I18n.t("courses.cart")} 1"
      end
    end
    context "when try to add seem course" do
      before do
        teachers_course
        visit root_path
        find(:css, ".main-card-link:first-child").click
        click_link I18n.t("add_to_cart")
        find(:css, ".main-card-link:first-child").click
        click_link I18n.t("add_to_cart")
      end
      it "should fail" do
        expect(page).to have_content I18n.t("courses.cart_notice")
      end
    end
  end
end
