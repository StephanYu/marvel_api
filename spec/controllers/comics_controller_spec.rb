require 'rails_helper'

RSpec.describe ComicsController, :type => :controller do

  describe "GET index" do
    it "assigns all comics as @comics" do
      comic = Comic.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:comics)).to eq([comic])
    end
  end

  describe "GET show" do
    it "assigns the requested comic as @comic" do
      comic = Comic.create! valid_attributes
      get :show, {:id => comic.to_param}, valid_session
      expect(assigns(:comic)).to eq(comic)
    end
  end

  describe "POST search" do 
    it "assigns all found comics as @comics"
    it "returns an empty array when nothing is searched"
    it "returns all comics ordered by the created_at date"
  end

  describe "POST toggle" do 
    it "increments the upvote attribute when upvoted"
    it "increments the downvote attribute when downvoted"
  end

end
