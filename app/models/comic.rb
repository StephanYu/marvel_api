class Comic < ApplicationRecord
  has_and_belongs_to_many :characters

  def self.search(search)
    Character.search(search)
    where("title LIKE ?", "%#{search}%")
  end
end
