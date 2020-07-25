require "rails_helper"
RSpec.feature "Courses", type: :feature do
  let (:member_user) { create(:user, role: 0 ) }
  let (:teacher_user) { create(:user, role: 1 ) }
  let (:admin_user) { create(:user, role: 2 ) }
  let (:admins_course) { create(:course, name: "admins_course", user_id: admin_user.id ) }
  let (:teachers_course) { create(:course, name: "teachers_course", user_id: teacher_user.id ) }

  describe "When member" do
    before do
      user_login(member_user)
    end
    it "should be can't create" do
      expect(page).not_to have_content I18n.t("courses.new")
    end

    context "when try to create" do
      before do
        visit courses_path
      end
      it "should be blocked" do
        expect(page).to have_content I18n.t("users.check_role")
      end
    end
  end

  describe "When teacher" do
    before do
      user_login(teacher_user)
      teachers_course
    end

    context "when create" do
      before do
        visit root_path
        click_link I18n.t("courses.new")
        page.fill_in "course[name]", with: "Example name"
        page.fill_in "course[description]", with: "Example description"
        page.fill_in "course[url]", with: "http://localhost:3000/courses/new"
        page.fill_in "course[price]", with: 1000
        select(I18n.t("activerecord.attributes.course.type_of_courses.math"), from: "course[type_of_course]").select_option
        select(I18n.t("activerecord.attributes.course.currencies.TWD"), from: "course[currency]").select_option
        select(7, from: "course[valididy_period]").select_option
        click_button I18n.t("submit")
      end
      it "should be create" do
        expect(page).to have_content 'Example name'
      end
    end

    context "when destroy" do
      before do
        visit courses_path
        click_link I18n.t("delete")
      end

      it "should be delete" do
        expect(page).to have_content I18n.t("courses.delete")
        expect(page).not_to have_content 'teachers_course'
      end
    end

    context "when update" do
      before do
        visit courses_path
        click_link I18n.t("edit")
        page.fill_in "course[name]", with: "edited"
        find('input[name="commit"]').click
        click_link I18n.t("courses.list")
      end

      it "should be update" do
        visit courses_path
        expect(page).to have_content "edited"
      end
    end

    context "only watch own course" do
      before do
        admins_course
        visit root_path
        click_link I18n.t("courses.list")
      end
      it "should be see one course" do
        expect(page).to have_content "teachers_course"
        expect(page).not_to have_content "admins_course"
      end
    end
  end

  describe "When admin" do
    before do
      user_login(admin_user)
      admins_course
    end

    context "when create" do
      before do
        visit root_path
        click_link I18n.t("courses.new")
        page.fill_in "course[name]", with: "Example name"
        page.fill_in "course[description]", with: "Example description"
        page.fill_in "course[url]", with: "http://localhost:3000/courses/new"
        page.fill_in "course[price]", with: 1000
        select(I18n.t("activerecord.attributes.course.type_of_courses.math"), from: "course[type_of_course]").select_option
        select(I18n.t("activerecord.attributes.course.currencies.TWD"), from: "course[currency]").select_option
        select(7, from: "course[valididy_period]").select_option
        click_button I18n.t("submit")
      end
      it "should be create" do
        expect(page).to have_content 'Example name'
      end
    end

    context "when destroy" do
      before do
        visit courses_path
        click_link I18n.t("delete")
      end

      it "should be delete" do
        expect(page).to have_content I18n.t("courses.delete")
        expect(page).not_to have_content 'teachers_course'
      end
    end

    context "when update" do
      before do
        visit courses_path
        click_link I18n.t("edit")
        page.fill_in "course[name]", with: "edited"
        find('input[name="commit"]').click
        click_link I18n.t("courses.list")
      end

      it "should be update" do
        visit courses_path
        expect(page).to have_content "edited"
      end
    end

    context "can see all course" do
      before do
        teachers_course
        admins_course
        visit root_path
        click_link I18n.t("courses.list")
      end
      it "should be see one course" do
        expect(page).to have_content "teachers_course"
        expect(page).to have_content "admins_course"
      end
    end

  end
end
