require "rails_helper"
RSpec.feature "Carts", type: :feature do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }
  let (:courses) {create_list(:course, 10, user_id: teacher_user.id)}
  let (:purchased_course) { create(:purchased_course, user_id: member_user.id, course_id: teachers_course.id) }

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
    context "when try to add own course" do
      before do
        purchased_course
        visit root_path
        find(:css, ".main-card-link:first-child").click
        click_link I18n.t("add_to_cart")
      end
      it "should be fail" do
        expect(page).to have_content I18n.t("courses.check_expirt_date")
      end
    end
  end
  describe "When checkout cart" do
    before do
      user_login(member_user)
    end
    context "when add two courses" do
      before do
        courses
        visit root_path
        find(:css, ".main-card-link:first-child").click
        click_link I18n.t("add_to_cart")
        find(:css, ".main-card-link:nth-child(2)").click
        click_link I18n.t("add_to_cart")
        click_link "#{I18n.t("courses.cart")} 2"
        click_link I18n.t("checkout")
      end
      it "should be success" do
        expect(page).to have_content I18n.t("courses.purchased_course_notice")
      end
      it "should be have two purchased_courses" do
        click_link I18n.t("users.purchased_courses")
        expect(all('.main-card-link').count).to eq 2
      end
    end
  end
end
