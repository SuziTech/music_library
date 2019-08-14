require_relative('../db/sql_runner')
require_relative('artist')

class Album

attr_reader :title, :genre, :id, :artist_id

def initialize( options )
  @id = options["id"].to_i if options["id"]
  @title = options["title"]
  @genre = options["genre"]
  @artist_id = options["artist_id"].to_i
end

def save
  sql = "INSERT INTO albums(
    artist_id,
    title,
    genre
  )
  VALUES($1, $2, $3)
  RETURNING id
  "
  values = [@artist_id, @title, @genre]
  result = SqlRunner.run(sql, values)
  @id = result[0]["id"].to_i
end

def Album.all
  sql = "SELECT * FROM albums"
  albums = SqlRunner.run(sql)
  return albums.map { | album | Album.new(album) }
end

def Album.delete_all
  sql = "DELETE FROM albums"
  SqlRunner.run(sql)
end

def artist
  sql = "SELECT * FROM artists
        WHERE id = $1"
  values = [@artist_id]
  results = SqlRunner.run(sql, values)
  artist_data = results[0]
  artist = Artist.new(artist_data)
  return artist
end






end
