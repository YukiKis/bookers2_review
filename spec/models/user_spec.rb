require "rails_helper"

RSpec.describe User, type: :model do
  let(:user){ create(:user) }
  context "on validation" do
    it "is valid" do
      expect(user).to be_valid
    end
    it "is invalid without name" do
      user.name = ""
      expect(user).to be_invalid
    end
    it "is invalid without email" do
      user.email = ""
      expect(user).to be_invalid
    end
    # it "is invalid without password" do
    #   user.encrypted_password = ""
    #   expect(user).to be_invalid
    # end
    it "has many books" do
      expect(User.reflect_on_association(:books).macro).to eq :has_many
    end
    it "has many favorites" do
      expect(User.reflect_on_association(:favorites).macro).to eq :has_many
    end
    it "has many comments" do
      expect(User.reflect_on_association(:coments).macro).to eq :has_many
    end
  end
end