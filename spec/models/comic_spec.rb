require 'rails_helper'

describe Comic do

  it { is_expected.to have_and_belong_to_many(:characters) }
        
  describe ".search" do
    let!(:comic) do
      create(:comic, title: "The Amazing Spider-Man")
    end
    before do
      comic.characters << create(:character)    
    end
    it "returns comics with a matching title"  do
      expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
      # result = Comic.search("Ant-Man").first.id
      # expect(result).to eq comic.id
    end

    context "when the query is for a character" do
      let!(:comic) do
        create(:comic, title: "Superman and friends")
      end
      let!(:spider_man) do 
        create(:character, name: "Spider-Man")
      end
      before do
        comic.characters << spider_man
      end
      it "returns comics where the character is involved"  do
        # binding.pry
        expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
      end
    end
  end
end