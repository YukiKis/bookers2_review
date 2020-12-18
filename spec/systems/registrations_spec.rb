require "rails_helper"

RSpec.describe "Registration", type: :system do
  describe "on user-registartion page" do
    it "has form for name" do
      expect(page).to have_field "user[name]"
    end
    it "has form for email" do
      expect(page).to have_field "user[email]"
    end
    it "has form for password" do
      expect(page).to have_field "user[password]"
    end
    it "has form for password_confirmation" do
      expect(page).to have_field "user[password_confirmation"
    end
    it "successfully register" do
      fill_in "user[name]", with: "Yuki"
      fill_in "user[email]", with: "yuki@com"
      fill_in "user[password]", with: "testtest"
      fill_in "user[password]", with: "testtest"
      click_button "Sign up"
      expect(current_path).to eq root_path
      expect(page).to have_content "successfully"
    end
    it "fails to register" do
      click_button "Sign up"
      expect(page).to have_content "error"
    end
  end
end