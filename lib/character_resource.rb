class CharacterResource
  attr_reader :base_url, :type

  def initialize
    @base_url = "https://gateway.marvel.com:443"
    @type     = "characters"
  end
end
