require 'rails_helper'

describe ComicsController do

  describe "GET index" do
    it "assigns all comics as @comics" do
      comics = create_list(:comic, 3).reverse
      get :index
      expect(assigns(:comics)).to eq(comics)
    end
  end

  describe "GET show" do
    it "assigns the requested comic as @comic" do
      comic = create(:comic)
      get :show, {:id => comic.to_param}
      expect(assigns(:comic)).to eq(comic)
    end
  end

  describe "POST search" do 
    context "with valid attributes" do
      xit "assigns found comics to @comics" do 
        post :search
      end
      xit "returns all comics ordered by the created_at date" do 
        post :search
      end
    end

    context "with invalid attributes" do
      xit "returns an empty array" do
        post :search
        expect(response).to eq([])
      end
    end
  end

  describe "POST toggle" do
    context "with valid attributes" do
      xit "increments the upvote attribute when upvoted" do 
        post :toggle
      end
      xit "increments the downvote attribute when downvoted" do 
        post :toggle
      end
    end
    context "with invalid attributes" do 
      xit "does not increment the upvote attribute" do 
        post :toggle
      end
      xit "does not increment the downvote attribute" do 
        post :toggle
      end
    end
  end

end
