require 'rails_helper'

describe "Comics" do
  describe "GET /comics" do
    it "returns the status code 200" do
      get comics_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /comics/search" do
    it "returns the status code 200" do
      get search_comics_path
      expect(response).to have_http_status(200)
    end
  end

  describe "POST /comic/:id/vote" do
    before { create(:comic) }
    it "returns the status code 200" do
      post vote_comic_path(:id =>'1', :vote_type => 'upvote')
      expect(response).to have_http_status(200)
    end
  end
end

