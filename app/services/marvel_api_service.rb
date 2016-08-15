require 'httparty'
require 'open-uri'

class MarvelApiService
  attr_reader :private_key, :public_key, :time_stamp, :hash

  def initialize
    @private_key  = ENV["private_key_marvel"]
    @public_key   = ENV["public_key_marvel"]
    @time_stamp   = Time.now.to_i
    @hash         = create_md5(@time_stamp.to_s, @private_key, @public_key)
  end

  def fetch_comics
    comic = ComicResource.new
    fetch(comic)
  end

  def fetch_characters
    character = CharacterResource.new
    fetch(character)
  end

  private

  def fetch(resource)
    data = get_metadata_for(resource)

    results_per_page = data["limit"].to_f
    total_num        = data["total"]
    total_page_count = (total_num/results_per_page).ceil
    results          = []
    base_url         = resource.base_url

    # TEMPORARY CHANGE: REMOVE AFTER TESTING!!!!!!!!!!!!!
    total_page_count = 1

    (0..total_page_count).each do |count|
      offset   = results_per_page * count
      url      = "#{base_url}/v1/public/#{resource.type}\?ts=#{time_stamp}&offset=#{offset}&apikey=#{public_key}&hash=#{hash}"
      response = send_request(url)
      results << response["data"]["results"]
    end
    results.flatten
  end
  
  def create_md5(ts, priv_key, pub_key)
    Digest::MD5.hexdigest(ts + priv_key + pub_key)
  end

  def send_request(url)
    HTTParty.get(url).parsed_response
  end

  def get_metadata_for(resource)
    url = "#{resource.base_url}/v1/public/#{resource.type}?ts=#{time_stamp}&limit=1&apikey=#{public_key}&hash=#{hash}" 
    response = send_request(url)

    response["data"]
  end
end