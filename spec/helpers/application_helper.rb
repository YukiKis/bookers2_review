require "rails_helper"

RSpec.describe "ApplicationHelper" do
  include ApplicationHelper
  describe "counter" do
    it "has righr number" do
      expect{ counter(3, "follower") }.to eq "3 followers"
      expect{ counter(1, "following") }.to eq "1 following"
    end
  end
end