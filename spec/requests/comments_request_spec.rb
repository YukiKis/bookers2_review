require 'rails_helper'

RSpec.describe "Comments", type: :request do
  context "on validation" do
    let(:user){ create(:user) }
    let(:book){ create(:book, user: user) }
    let(:comment){ create(:comment, book: book, user: user) }
    it "is valid" do
      expect(comment).to be_valid
    end
    it "is invalid without content" do
      comment.content = ""
      expect(comment).to be_invalid
    end
    it "belongs_to user" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to book" do
      expect(Comment.reflect_on_association(:book).macro).to eq :belongs_to
    end
  end
end
