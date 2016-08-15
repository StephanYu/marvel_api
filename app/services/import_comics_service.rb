class ImportComicsService
  def import
    comics = MarvelApiService.new.fetch_comics
    
    comics.map do |comic_response|
      id        = comic_response["id"]
      thumb_url = comic_response["thumbnail"]["path"]
      thumb_ext = comic_response["thumbnail"]["extension"]
      image_url = comic_response["images"].first["path"]
      image_ext = comic_response["images"].first["extension"]

      comic                 = Comic.find_or_initialize_by(marvel_comic_id: id)
      comic.title           = comic_response["title"]
      comic.description     = comic_response["description"]
      comic.thumbnail_url   = "#{thumb_url}.#{thumb_ext}"
      comic.image_url       = "#{image_url}.#{image_ext}"
      comic.marvel_comic_id = id
      comic.save
    end
  end
end


