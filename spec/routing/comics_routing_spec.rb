require "rails_helper"

RSpec.describe ComicsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/comics").to route_to("comics#index")
    end

    it "routes to #show" do
      expect(:get => "/comics/1").to route_to("comics#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/comics/1/edit").to route_to("comics#edit", :id => "1")
    end

    it "routes to #update" do
      expect(:put => "/comics/1").to route_to("comics#update", :id => "1")
    end
  end
end
