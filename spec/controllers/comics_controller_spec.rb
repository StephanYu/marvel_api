require 'rails_helper'

describe ComicsController do
  let!(:comics) { create_list(:comic, 3).reverse }
  let!(:comic) { comics.first }

  describe "GET index" do 
    let(:comic_response) { JSON.parse(response.body) }
    before { get :index }

    it "renders the comics in JSON" do
      response_equals_comic(comic_response.first, comics.first)
      response_equals_comic(comic_response.second, comics.second)
      response_equals_comic(comic_response.last, comics.last)
    end
  end

  describe "GET show" do
    let(:comic_response) { JSON.parse(response.body) }
    before { get :show, params: {:id => comic.to_param} }
    
    it "renders the requested comic as JSON" do
      response_equals_comic(comic_response, comic)
    end
  end

  describe "GET search" do 
    let(:older_comic) { create(:comic, :yesterday, title: "Superman vs Batman") }
    let(:newer_comic) { create(:comic, :today, title: "Batman") }
    before do 
      character = create(:character) 
      older_comic.characters << character
      newer_comic.characters << character
    end
    context "with valid attributes" do
      let(:comic_response) { JSON.parse(response.body) }
      before { get :search, params: { :query => "Batman" } }
      
      it "returns an array of all found comics ordered by the created_at date" do 
        response_equals_comic(comic_response.first, newer_comic)
        response_equals_comic(comic_response.second, older_comic)
      end
    end

    context "with invalid attributes" do
      before { get :search }

      it "returns an empty array" do
        expect(JSON.parse(response.body)).to eq([])
      end
    end
  end

  describe "POST vote" do
    let(:comic) { create(:comic) }
    context "when upvoting" do 
      let(:perform_action) { post :vote, params: { id: comic.id, comic: { vote_type: "upvote" } } }
      it "increments the upvote attribute" do 
        expect { perform_action }.to change { comic.reload.upvote }.by(1)
      end
    end

    context "when downvoting" do 
      let(:perform_action) { post :vote, params: { id: comic.id, comic: { vote_type: "downvote" } } }
      it "increments the downvote attribute" do 
        expect { perform_action }.to change { comic.reload.downvote }.by(1)
      end
    end

    context "with an invalid vote type" do 
      let(:perform_action) { post :vote, params: { id: comic.id, comic: { vote_type: "invalidvote" } } }

      it "does not increment upvote attribute" do 
        expect { perform_action }.not_to change { comic.reload.upvote }
      end
      it "does not increment downvote attribute" do 
        expect { perform_action }.not_to change { comic.reload.downvote }
      end
    end
  end

  def response_equals_comic(comic_response, comic)
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
