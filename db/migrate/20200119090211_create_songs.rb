class CreateSongs < ActiveRecord::Migration[6.0]
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :youtube_id
      t.integer :order
      t.time :time
      t.references :live, foreign_key: true

      t.timestamps
    end
  end
end
