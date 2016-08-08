require 'rails_helper'

RSpec.describe "Comics", :type => :request do
  describe "GET /comics" do
    it "works! (now write some real specs)" do
      get comics_path
      expect(response).to have_http_status(200)
    end
  end
end
