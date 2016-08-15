require 'rails_helper'

RSpec.describe Comic, :type => :model do
  describe ".search" do
    let!(:comic) do
      FactoryGirl.create(:comic, title: "The Amazing Spider-Man!")
    end
    it "returns comics with a matching character in the title"  do
      expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
    end

    context "when there is a matching character" do
      let!(:spider_man) do 
        FactoryGirl.create(:character, name: "Spider-Man")
      end
      it "returns comics whose character appear in the comic"  do
        expect(Comic.search("Spider-Man").map(&:id).sort).
        to eq [comic.id]
      end
    end
  end
end