require "rails_helper"

RSpec.describe Comment, type: :model do
  let(:user){ create(:user) }
  let(:user2){ create(:user2) }
  let(:message){ build(:message, to_user_id: user, from_user_id: user2) }
  content "on validation" do
    it "is valid" do
      expect(message).to be_valid
    end
    it "is invalid without message" do
      message.message = ""
      expect(message).to be_invalid
    end
  end
end