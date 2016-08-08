require 'httparty'
require 'open-uri'

namespace :marvel do 

  desc "Save each comic to the db and save its thumbnail image to the public/images folder as id_thumb.jpg"
  task :save_comics => :environment do 
    @comics = get_comics
    @comics.each do |comic|
      id = comic["id"]
      image_url = comic["thumbnail"]["path"]
      download = open("#{image_url}.#{comic["thumbnail"]['extension']}")
      IO.copy_stream(download, Rails.root.join("public","images/#{id}_thumb.jpg"))
      
      if Comic.exists?(marvel_comic_id: id)
        Comic.update_attributes(title: comic["title"], image_url: "/images/#{id}_thumb.jpg")
      else
        Comic.find_or_create_by(title: comic["title"], image_url: "/images/#{id}_thumb.jpg", marvel_comic_id: id)
      end
    end
  end

  desc "Save each comic character to the db"
  task :save_characters => :environment do 
    @characters = get_characters

    @characters.each do |character|
      comic_ids = character['comics']['items'].map do |comic|
        Comic.find_by(marvel_comic_id: comic['resourceURI'][/\/(\d+)\z/, 1].to_i).try(:id)
      end.compact

      if Character.exists?(name: character["name"])
        Character.update_attributes(name: character["name"]) do |character|
          character.comic_ids = comic_ids
        end
      else 
        Character.find_or_create_by(name: character["name"]) do |character|
          character.comic_ids = comic_ids
        end
      end
    end
  end

  def get_comics
    set_variables
    url = "http://gateway.marvel.com:80/v1/public/comics?ts=#{@time_stamp}&apikey=#{@public_key}&hash=#{@hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  def get_characters
    set_variables
    url = "https://gateway.marvel.com:443/v1/public/characters\?ts=#{@time_stamp}&apikey=#{@public_key}&hash=#{@hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  def create_md5(ts, priv_key, pub_key)
    Digest::MD5.hexdigest(ts + priv_key + pub_key)
  end

  def send_request(url)
    HTTParty.get(url).parsed_response
  end

  def set_variables 
    private_key  = ENV["private_key_marvel"]
    @public_key  = ENV["public_key_marvel"]
    @time_stamp  = Time.now.to_i
    @hash = create_md5(@time_stamp.to_s, private_key, @public_key)
  end
end
