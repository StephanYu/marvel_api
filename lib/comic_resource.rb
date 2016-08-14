class ComicResource
  attr_reader :base_url, :type

  def initialize
    @base_url = "http://gateway.marvel.com:80"
    @type     = "comics"
  end
end