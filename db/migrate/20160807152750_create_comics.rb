class CreateComics < ActiveRecord::Migration[5.0]
  def change
    create_table :comics do |t|
      t.string :title
      t.string :description
      t.string :image_url
      t.string :thumbnail_url
      t.integer :marvel_comic_id
      t.integer :upvote, default: 0, null: false
      t.integer :downvote, default: 0, null: false

      t.timestamps
    end
  end
end
