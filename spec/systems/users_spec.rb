require "rails_helper"

RSpec.describe User, type: :system do
  let!(:user){ create(:user) }  
  let!(:user2){ create(:user2) }
  before do  
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "Login"
  end
  context "on Index page" do
    before do
      visit users_path
    end
    it "is on right address" do
      expect(current_path). to eq users_path
    end
    it "has current_user_info in sidebar" do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end
    it "has book-form" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[opinion]"
    end
    it "has lists of users" do
      User.all.each do |u|
        expect(page).to have_link u.name, href: user_path(u)
      end
    end
  end
  context "on Show page" do
    before do
      visit user_path(user)
    end
    it "has user_info in sidebar" do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end
    it "has button for editing if current_user == user" do
      expect(page).to have_link "Edit", href: edit_user_path(user)
    end
    it "has NO BUTTON for editing if other user" do
      visit user_path(user2)
      expect(page).to have_no_link "Edit", href: edit_user_path(user2)
    end
    it "has button to follow for other user" do
      visit user_path(user2)
      expect(page).to have_link "Follow", href: user_relationship_path(user2)
    end
    it "has button to unfollow other user" do
      user.active_relationships.create(followed_id: user2.id)
      visit user_path(user2)
      expect(page).to have_link "Unfollow", href: user_relationship_path(user2)
    end
    it "has the link for folowers list" do
      expect(page).to have_link "Followers", href: followers_user_path(user)
    end
    it "has the link for followings list" do
      expect(page).to have_link "Followings", href: followings_user_path(use)
    end
    it "has book-list" do
      user.books.each do |b|
        expect(page).to have_link b.title, href: book_path(b)
      end
    end
    it "has button to follow user if it is the other user" do
      visit user_path(user2)
      expect(page).to have_link "Follow", href: user_relationship_path(user2)
    end
  end
  context "on Edit page" do
    before do
      visit edit_user_path(user)
    end
    it "redirects to the user page if it is not current user" do
      visit edit_user_path(user2)
      expect(current_path).to eq user_path(user2)
    end
    it "has form for name" do
      expect(page).to have_field "user[name]", with: user.name
    end
    it "has form for introduction" do
      expect(page).to have_field "user[introduction]", with: user.introduction
    end
    it "has button to update" do
      expect(page).to have_button "Update"
    end
    it "successfully updates" do
      fill_in "user[name]", with: "YUKIYUKI"
      fill_in "user[introduction]", with: "Hello world!"
      click_button "Update"
      expect(current_path).to eq user_path(user)
      expect(page).to have_content "YUKIYUKI"
      expect(page).to have_content "Hello world!"
    end
    it "fails to update" do
      fill_in "user[name]", with: ""
      click_button "Update"
      expect(page).to have_content "error"
    end
  end
  
  context "on follower page" do
    before do
      user.follow(user2)
      visit followers_user_path(user2)
    end
    it "has title 'Follower'" do
      expect(page).to have_content "Follower"
    end
    it "has follower list" do
      # checking with each
      user2.followers.each do |follower|
        expect(page).to have_link follower.name, href: user_path(follower)
        expect(page).to have_content follower.books.count
      end
      # checking using actual user
      expect(page).to have_link user.name, href: user_path(user)
      expect(page).to have_content user.books.count
    end
  end
  
  context "on following page" do
    before do
      user2.follow(user)
      visit followings_user_path(user2)
    end
    it "has title 'Following'" do
      expect(page).to have_content "Following"
    end
    it "has following list" do
      # checking with each
      user2.followings.each do |following| 
        expect(page).to have_link following.name, href: user_path(following)
        expect(page).to have_content following.books.count
      end
      # checking using actual user
      expect(page).to have_link user.name, href: user_path(user)
      expect(page).to have_content user.books.count
    end
  end
end