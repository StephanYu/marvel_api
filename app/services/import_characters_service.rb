class ImportCharactersService
  def import
    characters = MarvelApiService.new.fetch_characters

    characters.map do |character_response|
      id               = character_response["id"]
      marvel_comic_ids = character_response['comics']['items'].map do |comic|
        comic['resourceURI'][/\/(\d+)\z/, 1].to_i
      end.compact

      comics = Comic.where(marvel_comic_id: marvel_comic_ids)

      character        = Character.find_or_initialize_by(marvel_character_id: id)
      character.comics = comics
      character.name   = character_response["name"]
      character.save
    end
  end
end