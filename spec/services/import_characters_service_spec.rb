require "rails_helper"

describe ImportCharactersService do 
  
  shared_examples_for "an action to save characters in the database" do
    before { ImportCharactersService.new.import }
    
    it "persists the character from the response into the database" do
      expect(character.name).to eq(characters_response.first["name"])
      expect(character.marvel_character_id).to eq(characters_response.first["id"])
      expect(character.comics.map(&:marvel_comic_id).sort).
        to eq comics.map(&:marvel_comic_id).sort
    end
  end

  describe "#import" do 
    let(:characters_response) do
      [
        { "id"=>1011334,
          "name"=>"3-D Man",
          "comics"=>{
            "items"=>[
              {"resourceURI"=>"http://gateway.marvel.com/v1/public/comics/21366", "name"=>"Avengers: The Initiative (2007) #14"},
              {"resourceURI"=>"http://gateway.marvel.com/v1/public/comics/24571", "name"=>"Avengers: The Initiative (2007) #14 (SPOTLIGHT VARIANT)"},
              {"resourceURI"=>"http://gateway.marvel.com/v1/public/comics/21546", "name"=>"Avengers: The Initiative (2007) #15"}
            ]
          }
        }
      ]
    end

    let(:character) { Character.last }

    let!(:comics) do
      [
        FactoryGirl.create(:comic, marvel_comic_id: 21366),
        FactoryGirl.create(:comic, marvel_comic_id: 24571),
        FactoryGirl.create(:comic, marvel_comic_id: 21546)
      ]
    end

    before do
      allow_any_instance_of(MarvelApiService).
        to receive(:fetch_characters).
        and_return(characters_response)
    end

    context "character already existent in database" do 
      before do
        FactoryGirl.create(:character, marvel_character_id: characters_response.first["id"])
      end
      
      it "does not create a new character entry" do 
        expect { ImportCharactersService.new.import }.
          not_to change { Character.count }
      end

      it_behaves_like "an action to save characters in the database"
    end

    context "character not yet existent in database" do
      it "creates a new character entry" do 
        expect { ImportCharactersService.new.import }.
          to change { Character.count }.by(1)
      end

      it_behaves_like "an action to save characters in the database"
    end
  end
end



