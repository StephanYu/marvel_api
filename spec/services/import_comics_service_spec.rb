require "rails_helper"

describe ImportComicsService do 
  
  shared_examples_for "an action to save comics in the database" do
    before { ImportComicsService.new.import }
    let(:image_url) { "#{comics_response.first["images"].first["path"]}.#{comics_response.first["images"].first["extension"]}" }
    let(:thumbnail_url) { "#{comics_response.first["thumbnail"]["path"]}.#{comics_response.first["thumbnail"]["extension"]}" }

    it "persists the comic from the response into the database" do
      expect(comic.title).to eq(comics_response.first["title"])
      expect(comic.description).to eq(comics_response.first["description"])
      expect(comic.image_url).to eq(image_url)
      expect(comic.thumbnail_url).to eq(thumbnail_url)
      expect(comic.marvel_comic_id).to eq(comics_response.first["id"])
    end
  end

  describe "#import" do 
    let(:comics_response) do
      [
        { "id"=> 41530,
          "title"=> "Ant-Man: So (Trade Paperback)",
          "description"=> "It's the origin of the original Avenger, Ant-Man! Hank Pym has been known by a variety of names - including Ant-Man, Giant-Man, Goliath and Yellowjacket - he's been an innovative scientist, a famed super hero, an abusive spouse and more. What demons drive a man like Hank Pym? And how did he begin his heroic career?",
          "thumbnail"=> {
            "path"=> "http://i.annihil.us/u/prod/marvel/i/mg/c/30/4fe8cb51f32e0",
            "extension"=> "jpg"
          },
          "images"=> [
            {
              "path"=> "http://i.annihil.us/u/prod/marvel/i/mg/c/30/4fe8cb51f32e0",
              "extension"=> "jpg"
            }
          ]
        }
      ]
    end

    let(:comic) { Comic.last }

    before do
      allow_any_instance_of(MarvelApiService).
        to receive(:fetch_comics).
        and_return(comics_response)
    end

    context "comic already existent in database" do 
      before do
        FactoryGirl.create(:comic, marvel_comic_id: comics_response.first["id"])
      end

      it "does not create a new comic entry" do 
        expect { ImportComicsService.new.import }.
          not_to change { Comic.count }
      end

      it_behaves_like "an action to save comics in the database"
    end

    context "comic not yet existent in database" do
      it "creates a new comic book entry" do 
        expect { ImportComicsService.new.import }.
          to change { Comic.count }.by(1)
      end

      it_behaves_like "an action to save comics in the database"
    end
  end
end

