class ImportCharactersService
  def import
    characters = MarvelApiService.new.fetch_characters
    binding.pry
    characters.map do |character|
      id        = character["id"]
      comic_ids = character['comics']['items'].map do |comic|
        Comic.find_by(marvel_comic_id: comic['resourceURI'][/\/(\d+)\z/, 1].to_i).try(:id)
      end.compact

      if Character.exists?(marvel_character_id: id)
        Character.find_by_marvel_character_id(id).update(name: character["name"]) do |character|
          character.comic_ids = comic_ids
        end
      else 
        Character.create(name: character["name"], marvel_character_id: id) do |character|
          character.comic_ids = comic_ids
        end
      end
    end
  end
end