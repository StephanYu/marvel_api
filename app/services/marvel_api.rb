require 'httparty'
require 'open-uri'

class MarvelApi
  attr_reader :private_key, :public_key, :time_stamp, :hash

  def initialize
    @private_key  = ENV["private_key_marvel"]
    @public_key   = ENV["public_key_marvel"]
    @time_stamp   = Time.now.to_i
    @hash         = create_md5(@time_stamp.to_s, private_key, @public_key)
  end

  def fetch(resource)
    data = get_metadata_for(resource)

    results_per_page = data["limit"].to_f
    total_num        = data["total"]
    total_page_count = (total_num/results_per_page).ceil
    results          = []
    
    base_url = "http://gateway.marvel.com:80" if resource == :comics
    base_url = "https://gateway.marvel.com:443" if resource == :characters

    # TEMPORARY CHANGE: REMOVE AFTER TESTING!!!!!!!!!!!!!
    total_page_count = 1

    (0..total_page_count).each do |count|
      offset   = results_per_page * count
      url      = "#{base_url}/v1/public/#{resource}\?ts=#{time_stamp}&offset=#{offset}&apikey=#{public_key}&hash=#{hash}"
      response = send_request(url)
      results << response["data"]["results"]
    end
    results.flatten
  end

  private
  
    def create_md5(ts, priv_key, pub_key)
      Digest::MD5.hexdigest(ts + priv_key + pub_key)
    end

    def send_request(url)
      HTTParty.get(url).parsed_response
    end

    def get_metadata_for(resource)
      if resource == :comics
        url = "http://gateway.marvel.com:80/v1/public/comics?ts=#{time_stamp}&limit=1&apikey=#{public_key}&hash=#{hash}" 
      else
        url = "https://gateway.marvel.com:443/v1/public/characters\?ts=#{time_stamp}&limit=1&apikey=#{public_key}&hash=#{hash}"
      end
      response = send_request(url)
      response["data"]
    end

    def save_images(comic)
      comic_id  = comic["id"]

      # download thumbnail images for the index page
      thumb_url = comic["thumbnail"]["path"]
      thumb_ext = comic["thumbnail"]['extension']
      download  = open("#{thumb_url}.#{thumb_ext}")
      IO.copy_stream(download, Rails.root.join("public","images/#{comic_id}_thumb.jpg"))

      # download large image for the show details section
      image_url = comic["images"].first["path"]
      image_ext = comic["images"].first['extension']
      download  = open("#{image_url}.#{image_ext}")
      IO.copy_stream(download, Rails.root.join("public","images/#{comic_id}_image.jpg"))
    end
end