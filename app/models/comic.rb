class Comic < ApplicationRecord
  has_and_belongs_to_many :characters

  def self.search(search)
    where("title LIKE ?", "%#{search}%")
    where("characters LIKE ?", "%#{search}%")
  end
end
