json.extract! song, :id, :name, :artist, :order, :time
json.youtube_id song.open? ? song.youtube_id : ""
