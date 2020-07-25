require "rails_helper"
RSpec.feature "Users", type: :feature do
  let (:user) { create(:user)}
  before do
    user_login(user)
  end
  describe "Session" do
    context "When create" do
      it "should be successful" do
        expect(page).to have_content I18n.t("devise.sessions.signed_in")
      end
    end
    context "When destroy" do
      it "should be successful" do
        click_link I18n.t("users.log_out")
        expect(page).to have_content I18n.t("devise.sessions.signed_out")
      end
    end
  end
  describe "User" do
    context "When create" do
      before do
        click_link I18n.t("users.log_out")
        visit new_user_registration_path
        fill_in "user[name]", with: "sample"
        fill_in "user[email]", with: "sample@gmail.com"
        fill_in "user[password]", with: "123456"
        fill_in "user[password_confirmation]", with: "123456"
        select(I18n.t("activerecord.attributes.user.roles.member"), from: "user[role]").select_option
        click_button I18n.t("users.sign_up")
      end
      it "should be created successfully" do
        expect(page).to have_content I18n.t("notice.user.create_success")
      end
    end
  end
end
