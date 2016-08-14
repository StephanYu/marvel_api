class ImportComicsService
  def import
    comics = MarvelApiService.new.fetch_comics
    
    comics.map do |comic|
      id        = comic["id"]
      thumb_url = comic["thumbnail"]["path"]
      thumb_ext = comic["thumbnail"]["extension"]
      image_url = comic["images"].first["path"]
      image_ext = comic["images"].first["extension"]

      if Comic.exists?(marvel_comic_id: id)
        Comic.find_by_marvel_comic_id(id).update(title: comic["title"], description: comic["description"], thumbnail_url: "#{thumb_url}.#{thumb_ext}", image_url: "#{image_url}.#{image_ext}")
      else
        Comic.create(title: comic["title"], description: comic["description"], thumbnail_url: "#{thumb_url}.#{thumb_ext}", image_url: "#{image_url}.#{image_ext}", marvel_comic_id: id)
      end
    end
  end
end


