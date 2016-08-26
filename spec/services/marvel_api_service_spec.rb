require "rails_helper"

describe MarvelApiService do 
  describe "#fetch_comics", :vcr do
    subject do 
      VCR.use_cassette("comics") do
        Timecop.freeze(Time.local(2016, 8, 25, 15, 24)) do
          MarvelApiService.new.fetch_comics
        end.first
      end
    end
    let(:comic) { create(:comic) }

    it "returns a list of comics" do
      expect(subject["title"]).to eq "Lorna the Jungle Girl (1954) #6"
      expect(subject["description"]).to be_nil
      expect(subject["id"]).to eq 42882
      expect(subject["images"].first["path"]).to eq "http://i.annihil.us/u/prod/marvel/i/mg/9/40/50b4fc783d30f"
      expect(subject["thumbnail"]["path"]).to eq "http://i.annihil.us/u/prod/marvel/i/mg/9/40/50b4fc783d30f"
    end
  end
    
  describe "#fetch_characters", :vcr do 
    subject do 
      VCR.use_cassette("characters") do
        Timecop.freeze(Time.local(2016, 8, 25, 15, 24)) do
          MarvelApiService.new.fetch_characters
        end.first
      end
    end
    
    it "returns a list of characters" do
      expect(subject["id"]).to eq 1011334
      expect(subject["name"]).to eq "3-D Man"
      expect(subject["comics"]["items"].first["name"]).to eq "Avengers: The Initiative (2007) #14"
    end
  end
end

