namespace :marvel do 

  desc "Save comics to the db and images to the public folder"
  task :save_comics => :environment do 
    marvel = MarvelApi.new
    comics = marvel.fetch :comics
    binding.pry
    comics.each do |comic|
      id = comic["id"]

      marvel.save_images(comic)

      if Comic.exists?(marvel_comic_id: id)
        Comic.update_attributes(title: comic["title"], description: comic["description"], thumbnail_url: "/images/#{id}_thumb.jpg", image_url: "/images/#{id}_image.jpg")
      else
        Comic.find_or_create_by(title: comic["title"], description: comic["description"], thumbnail_url: "/images/#{id}_thumb.jpg", image_url: "/images/#{id}_image.jpg", marvel_comic_id: id)
      end
    end
  end

  desc "Save each comic character to the db"
  task :save_characters => :environment do 
    marvel     = MarvelApi.new
    characters = marvel.fetch :characters

    characters.each do |character|
      id        = character["id"]
      comic_ids = character['comics']['items'].map do |comic|
        Comic.find_by(marvel_comic_id: comic['resourceURI'][/\/(\d+)\z/, 1].to_i).try(:id)
      end.compact

      if Character.exists?(marvel_character_id: id)
        Character.update_attributes(name: character["name"]) do |character|
          character.comic_ids = comic_ids
        end
      else 
        Character.find_or_create_by(name: character["name"], marvel_character_id: id) do |character|
          character.comic_ids = comic_ids
        end
      end
    end
  end

end
