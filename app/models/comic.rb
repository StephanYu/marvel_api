class Comic < ApplicationRecord
  has_and_belongs_to_many :characters

  def self.search(search_term)
    where("title LIKE ?", "%#{search_term}%")
  end
end
