RSpec.describe "books-page", type: :system do
  let!(:user){ create(:user) }
  let!(:user2){ create(:user2) }
  let(:book){ create(:book, user: user) }
  let(:book2){ create(:book, user: user) }
  let(:book3){ create(:book, user: user2) }
  let(:book4){ create(:book, user: user2) }
  before do
    visit new_user_session_path
    fill_in "user[name]", with: user.name
    fill_in "user[password]", with: user.password
    click_button "Login"
  end
  context "on index page" do
    it "has current_user_info on sidebar" do
      expect(page).to have_content user.name
      expect(page).to have_content user.introduction
    end
    it "has edit button" do
      expect(page).to have_link "Edit", href: edit_user_path(user)
    end
    it "has book-form" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[opinion]"
    end
    it "has book-list" do
      Book.all.each do |book|
        #expect(page).to have_content book.user.name
        expect(page).to have_content book.title
        expect(page).to have_content book.opinion
      end
    end
  end
  context "on show page" do
    before do
      visit book_path(book3) # user2
    end
    it "has THE user info on sidebar" do
      expect(page).to have_content user2.name
      expect(page).to have_content user2.introduction
    end
    it "has form for new booK" do
      expect(page).to have_field "book[title]"
      expect(page).to have_field "book[opinion]"
    end
    it "has book info" do
      expect(page).to have_link "", href: user_path(user2)
      expect(page).to have_content book3.title
      expect(page).to have_content book3.opinion
    end
    it "has button to make it favorite" do
      expect(page).to have_selector "a[data-method=post]"
    end
    it "has button to remove favorite" do
      book3.favorites.create(user_id: user)
      visit current_path
      expect(page).to have_selector "a[data-method=delete]" 
    end
    it "has NO BUTTON for edit either destroy if not THE USER" do
      expect(page).to have_no_link "Edit", href: edit_book_path(book3)
      expect(page).to have_no_link "Destroy", href: book_path(book3)
    end
    it "HAS BUTTON for edit and destroy" do
      visit book_path(book)
      expect(page).to have_link "Edit", href: edit_book_path(book)
      expect(page).to have_link "Destroy", href: book_path(book)
    end
    it "has comment-table" do
      book.comments.each do |comment|
        expect(page).to have_link "", href: user_path(comment.user)
        expect(page).to have_content comment.content
      end
    end
    #it "has button to delete comment" do
    #end
  end
  context "on edit page" do
    before do
      visit edit_book_path(book)
    end
    it "has form for title" do
      expect(page).to have_field "book[title]", with: book.title
    end
    it "has form for opinion" do
      expect(page).to have_field "book[opinion]", with: book.opinion
    end
    it "has button to update" do
      expect(page).to have_button "Update"
    end
    it "successfully update" do
      fill_in "book[title]", with: "HELLO"
      fill_in "book[opinion]", with: "WORLD"
      click_button "Update"
      expect(current_path).to eq book_path(book)
      expect(page).to have_content "HELLO"
      expect(page).to have_content "WORLD"
    end
    it "fails to update" do
      fill_in "book[title]", with: ""
      click_button "Update"
      expect(page).to have_content "error"
    end
    it "has link to show page" do
      expect(page).to have_link "Show", href: book_path(book)
    end
    #it "has link to Back page" do
    #  expect(page).to have_link "Back", href: request.referer
    #end
  end
end