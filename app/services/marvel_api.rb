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

  def get_comics
    # make initial request to obtain meta data with limit 1
      # extract data(total, limit)
      # results_per_page = ["data"]["limit"]
      # total_comics = ["data"]["total"]
      # total_page_count = total_comics / results_per_page # rounded up
      # results = []

    # iterate for total_page_count
      # make get request and save data to array? with every request changing the offset variable offset = results_per_page * counter(0..total_page_count)
      #  
    url = "http://gateway.marvel.com:80/v1/public/comics?ts=#{time_stamp}&offset=#{offset}&apikey=#{public_key}&hash=#{hash}"
    response = send_request(url)
    response["data"]["results"]
  end

  def get_characters
    url = "https://gateway.marvel.com:443/v1/public/characters\?ts=#{time_stamp}&apikey=#{public_key}&hash=#{hash}"
    response = send_request(url)
    response["data"]["results"]
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

  private
  
    def create_md5(ts, priv_key, pub_key)
      Digest::MD5.hexdigest(ts + priv_key + pub_key)
    end

    def send_request(url)
      HTTParty.get(url).parsed_response
    end
end