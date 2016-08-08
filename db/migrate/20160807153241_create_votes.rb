class CreateVotes < ActiveRecord::Migration[5.0]
  def change
    create_table :votes do |t|
      t.references :comic, foreign_key: true
      t.integer :direction

      t.timestamps
    end
  end
end
