require "rails_helper"

RSpec.describe Favorite, type: :model do
  context "on validation" do
    it "belongs_to user" do
      expect(Favorite.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "belongs_to book" do
      expect(Favorite.reflect_on_association(:book).macro).to eq :belongs_to
    end
  end
end