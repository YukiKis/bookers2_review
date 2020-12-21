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
end