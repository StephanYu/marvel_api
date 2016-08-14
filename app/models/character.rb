class Character < ApplicationRecord
  has_and_belongs_to_many :comics

  def self.search(search)
    where("name LIKE ?", "%#{search}%").includes(comics) 
  end
end
