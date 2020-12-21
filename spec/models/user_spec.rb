require "rails_helper"

RSpec.describe User, type: :model do
  let(:user){ create(:user) }
  let(:user2){ create(:user2) }
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
      expect(User.reflect_on_association(:comments).macro).to eq :has_many
    end
    it "has many active_relationships" do
      expect(User.reflect_on_association(:active_relationships).macro).to eq :has_many
    end
    it "has many passive_relationships" do
      expect(User.reflect_on_association(:passive_relationships).macro).to eq :has_many
    end
    it "has many followers" do
      expect(User.reflect_on_association(:followers).macro).to eq :has_many
    end
    it "has many followings" do
      expect(User.reflect_on_association(:followings).macro).to eq :has_many
    end
    it "has follow method to add new following count" do
      expect{ user.follow(user2) }.to change{ user.followings.count }.by(1)
    end
    it "has unfollow method to decrease following number" do
      user.follow(user2)
      expect{ user.unfollow(user2) }.to change{ user.followings.count }.by(-1)
    end
  end
end