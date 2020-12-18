require "rails_helper"

RSpec.describe "user-session page", type: :system do
  describe "on new-user-session page" do
    let(:user){ User.create(name: "yuki", email: "yuki@com", password: "testtest") }
    it "has field for name" do
      expect(page).to have_field "uesr[name]"
    end
    it "has field for password" do
      expect(page).to have_field "user[password"
    end
    it "successfully log in" do
      fill_in "user[name]", with: user.name
      fill_in "user[password]", with: user.password
      click_button "Login"
      expect(page).to have_content "successfully"
    end
    it "fails to log in" do
      click_button "Login"
      expect(page).to have_content "error"
    end
  end
end