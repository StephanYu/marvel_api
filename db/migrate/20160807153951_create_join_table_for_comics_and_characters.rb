class CreateJoinTableForComicsAndCharacters < ActiveRecord::Migration[5.0]
  def change
    create_join_table :comics, :characters do |t|
      t.index :comic_id
      t.index :character_id
    end
  end
end
