require "rails_helper"

describe MarvelApiService do 
  describe "#fetch_comics" do
    subject { MarvelApiService.new.fetch_comics }
    
    let(:comic) do
      create(:comic,
             title: "Lorna the Jungle Girl (1954) #6"
             thumbnail: )
    end

    it "returns a list of comics" do
      VCR.use_cassette 'model/api_response' do
        expect(subject.first).to 
      end
    end
  end
    
  describe "#fetch_characters" do 
    subject { MarvelApiService.new.fetch_characters }
    
    it "returns a list of characters" do
      # TO-DO: store request in VCR and verify results is a list of characters
      expect(subject.first).to be_a Character
    end
  end
end

