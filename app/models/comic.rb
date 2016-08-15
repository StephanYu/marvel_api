class Comic < ApplicationRecord
  has_and_belongs_to_many :characters

  def self.search(search_term)
    where("title LIKE ?", "%#{search_term}%")
  end

  # comics = Comic.joins("join characters_comics on comic.id = characters_comics.character_id").where(["characters_comics.character_id = ?", character_id])

  # @comics = Comic.includes(:characters).where(characters: { name: search_term })
  # @comics = Comic.includes(:characters).where('character.name' => search_term)

end
