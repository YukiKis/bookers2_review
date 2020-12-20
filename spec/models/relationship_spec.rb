require "rails_helper"

RSpec.describe Relationship, type: :model do
  context "on validation" do
    it "belongs_to follower" do
      expect(PassiveRelationship.reflect_on_association(:follower).macro).to eq :belongs_to
    end
    it "belongs_to following" do
      expect(PassiveRelationship.reflect_on_association(:followed).macro).to eq :belongs_to
    end
  end
end