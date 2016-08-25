require 'rails_helper'

describe ComicsController do
  let!(:comics) { create_list(:comic, 3).reverse }
  let!(:comic) { comics.first }

  describe "GET index" do 
    let(:comic_response) { JSON.parse(response.body).first }
    before { get :index }
    
    it "renders the comics in JSON" do
      expect(comic_response["id"]).to eq(comic.id)
      expect(comic_response["title"]).to eq(comic.title)
      expect(comic_response["description"]).to eq(comic.description)
      expect(comic_response["marvel_comic_id"]).to eq(comic.marvel_comic_id)
      expect(comic_response["upvote"]).to eq(comic.upvote)
      expect(comic_response["downvote"]).to eq(comic.downvote)
      expect(comic_response["image_url"]).to eq(comic.image_url)
      expect(comic_response["thumbnail_url"]).to eq(comic.thumbnail_url)
    end
  end

  describe "GET show" do
    let(:comic_response) { JSON.parse(response.body) }
    before { get :show, {:id => comic.to_param} }
    
    it "renders the requested comic as JSON" do
      expect(comic_response["id"]).to eq(comic.id)
      expect(comic_response["title"]).to eq(comic.title)
      expect(comic_response["description"]).to eq(comic.description)
      expect(comic_response["marvel_comic_id"]).to eq(comic.marvel_comic_id)
      expect(comic_response["upvote"]).to eq(comic.upvote)
      expect(comic_response["downvote"]).to eq(comic.downvote)
      expect(comic_response["image_url"]).to eq(comic.image_url)
      expect(comic_response["thumbnail_url"]).to eq(comic.thumbnail_url)
    end
  end

  describe "GET search" do 
    let(:comic) { create(:comic, :yesterday) }
    let(:comic_2) { create(:comic, :today) }

    context "with valid attributes" do
      let(:comic_response) { JSON.parse(response.body) }
      before { get :search, :query => comic.title }
      
      it "returns an array of found comics in JSON" do 
        expect(response).to be_ok
        binding.pry
        expect(comic_response).to include(comic)
      end

      xit "returns an array of all found comics ordered by the created_at date" do 
        expect(response).to be_ok
        expect(response.body).to include([comic_2, comic])
      end
    end

    context "with invalid attributes" do
      before { get :search }

      xit "returns an empty array" do
        expect(response).to_not be_ok
        expect(response).to eq([])
      end
    end
  end

  describe "POST toggle" do
    before { post :toggle }
    
    context "with valid attributes" do
      xit "increments the upvote attribute when upvoted" do 
      end
      xit "increments the downvote attribute when downvoted" do 
      end
    end
    context "with invalid attributes" do 
      xit "does not increment the upvote attribute" do 
      end
      xit "does not increment the downvote attribute" do 
      end
    end
  end

end
