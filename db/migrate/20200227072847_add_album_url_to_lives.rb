class AddAlbumUrlToLives < ActiveRecord::Migration[6.0]
  def change
    add_column :lives, :album_url, :string
  end
end
