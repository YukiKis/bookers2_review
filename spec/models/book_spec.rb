require 'rails_helper'

RSpec.describe Book, type: :model do
  let(:user){ create(:user) }
  let(:book){ create(:book, user: user) }
  context "on validation" do
    it "is valid" do
      expect(book).to be_valid
    end
    it "is invalid without title" do
      book.title = ""
      expect(book).to be_invalid
    end
    it "is invalid without opinion" do
      book.opinion = ""
      expect(book).to be_invalid
    end
    it "belongs_to user" do
      expect(Book.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "has many favorites" do
      expect(Book.reflect_on_association(:favorites).macro).to eq :has_many
    end
    it "has many comments" do
      expect(Book.reflect_on_association(:comments).macro).to eq :has_many
    end
  end
end
