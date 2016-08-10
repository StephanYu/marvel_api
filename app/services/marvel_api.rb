require 'httparty'
require 'open-uri'

class MarvelApi

  def initialize
    @private_key  = ENV["private_key_marvel"]
    @public_key   = ENV["public_key_marvel"]
    @time_stamp   = Time.now.to_i
    @hash         = create_md5(@time_stamp.to_s, private_key, @public_key)
  end

  def get_comics
    url = "http://gateway.marvel.com:80/v1/public/comics?ts=#{@time_stamp}&apikey=#{@public_key}&hash=#{@hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  def get_characters
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

  def save_image(comic, image_type)
    id = comic["id"]
    
    if image_type == "thumbnail"
      image_url = comic["thumbnail"]["path"]
      download = open("#{image_url}.#{comic["thumbnail"]['extension']}")
      IO.copy_stream(download, Rails.root.join("public","images/#{id}_thumb.jpg"))
    else
      # image_url = comic["thumbnail"]["path"]
      # download = open("#{image_url}.#{comic["thumbnail"]['extension']}")
      # IO.copy_stream(download, Rails.root.join("public","images/#{id}_thumb.jpg"))
    end
  end
end