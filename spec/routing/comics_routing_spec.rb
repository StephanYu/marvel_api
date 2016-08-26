require "rails_helper"

RSpec.describe ComicsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/comics").to route_to("comics#index")
    end

    it "routes to #show" do
      expect(:get => "/comics/1").to route_to("comics#show", :id => "1")
    end

    it "routes to #search" do
      expect(:get => "/comics/search?query=superman").to route_to("comics#search", :query => "superman")
    end

    it "routes to #vote" do
      expect(:post => "/comics/1/vote?comic[vote_type]=upvote").to route_to("comics#vote", comic: { "vote_type" => "upvote" }, id: "1")
    end
  end
end
