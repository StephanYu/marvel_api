require 'httparty'
require 'open-uri'

namespace :marvel do 

  desc "Make request to the marvel api for all comics"
  task :get_comics do 
    set_variables
    url = "http://gateway.marvel.com:80/v1/public/comics?ts=#{@time_stamp}&apikey=#{@public_key}&hash=#{@hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  desc "Make request to the marvel api for all characters"
  task :get_characters do 
    set_variables
    url = "https://gateway.marvel.com:443/v1/public/characters\?ts=#{@time_stamp}&apikey=#{@public_key}&hash=#{@hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  desc "Save each comic to the db and save its thumbnail image to the public/images folder as id_thumb.jpg"
  task :save_comics do 
    @comics = get_comics

    @comics.each do |comic|
      id = comic["id"]
      image_url = comic["thumbnail"]["path"]
      download = open(image_url)
      IO.copy_stream(download, "/images/#{id}_thumb.jpg")

      Comic.find_or_create_by(title: comic["title"], image_url: "/images/#{id}_thumb.jpg")
    end
  end

  desc "Save each comic character to the db"
  task :save_characters do 
    @characters = get_characters

    @characters.each do |character|
      Character.find_or_create_by(name: character["name"])
    end
  end

  desc "Check Marvel API for any updates in comics collections"
  task :check_and_update_comics do 
    @comics = get_comics
    # if the last comic entry differs from the one in the local db, then 
  end

  desc "Check Marvel API for any updates in characters collections"
  task :check_and_update_characters do 
    @characters = get_characters
  end

  def get_comics
    Rake::Task["marvel:get_comics"].invoke
  end

  def get_characters
    Rake::Task["marvel:get_characters"].invoke
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
    @hash = create_md5(@time_stamp.to_s + private_key + @public_key)
  end
end
