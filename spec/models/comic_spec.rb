require 'rails_helper'

RSpec.describe Comic, :type => :model do
  describe ".search" do
    let!(:comic) do
      FactoryGirl.create(:comic, title: "The Amazing Spider-Man!")
    end
    it "returns comics with a matching title"  do
      expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
    end

    context "when the query is for a character" do
      let!(:spider_man) do 
        FactoryGirl.create(:character, name: "Spider-Man")
      end
      it "returns comics where the character is involved"  do
        expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
      end
    end
  end
end