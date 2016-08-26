class Comic < ApplicationRecord
  has_and_belongs_to_many :characters

  def self.search(search_term)
    results = Comic.joins(:characters).
      where("characters.name LIKE ?", "%#{search_term}%").
      or(Comic.joins(:characters).where("comics.title LIKE ?", "%#{search_term}%"))
    results
  end
end
