require 'rails_helper'

RSpec.describe ComicsController, :type => :controller do

  describe "GET index" do
    it "assigns all comics as @comics" do
      comics = FactoryGirl.create_list(:comic, 3).reverse
      get :index
      expect(assigns(:comics)).to eq(comics)
    end
  end

  describe "GET show" do
    it "assigns the requested comic as @comic" do
      comic = FactoryGirl.create(:comic)
      get :show, {:id => comic.to_param}
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
