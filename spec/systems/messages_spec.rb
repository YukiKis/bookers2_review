require "rails_helper"

RSpec.describe "messages-page", type: :system do
  let(:user){ create(:user) }
  let(:user2){ create(:user2) }
  let(:message){ create(:message, to_user_id: user, from_user_id: user2) }
  
  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "Login"
  end

  context "on index page" do
    before do
      visit messages_user_path(user)
      @list = User.all.map do |u|
        if u.have_message?(u)
          u
        end
      end
    end
    it "has message users list" do
      #check by each
      @list.each do |u|
        expect(page).to have_link u.name, href: user_path(u)
        expect(page).to have_content user.get_messages(u).last.message
        expect(page).to have_link "See More", href: message_user_path(user, u)
      end
      #check with actual
      expect(page).to have_link user2.name, href: user_path(user2)
      expect(page).to have_content user.get_messages(user2).last_message
      expect(page).to have_link "See More", href: message_user_path(user, user2)
    end
  end
  
  context "on show page" do
    before do
      visit message_user_path(user, user2)
    end
    it "has user_name" do
      expect(page).to have_content user2.name
    end
    it "has message list" do
      messages = user.get_messages(usre2)
      messages.each do |m|
        expect(page).to have_content m
      end
    end
    it "has message-form" do
      expect(page).to have_field "message[message]"
      expect(page).to have_button "Post"
    end
    it "succeeds to send a message" do
      fill_in "message[message]", with: "Hello"
      click_button "Post"
      expect(page).to have_content "Hello"
    end
    it "succeeds to get a message" do
      fill_in "message[message]", with: "Hello"
      click_button "Post"
      expect(page).to have_content "Hello"
      click_link "Logout"
      visit new_user_session_path
      fill_in "user[name]", with: user2.name
      fill_in "user[password]", with: user2.password
      click_button "Login"
      expect(page).to have_content "successfully"
      visit message_user_path(user2, user)
      expect(page).to have_content "Hello"
    end
    it "has back button" do
      expect(page).to have_link "Back", href: messages_user_path(user)
    end
  end
end