require_relative('../db/sql_runner')
require_relative('album')

class Artist

  attr_reader :id, :name

  def initialize( options )
    @name = options['name']
    @id = options['id'].to_i if options['id']
  end

  def save
    sql = "INSERT INTO artists (name)
    VALUES ($1)
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def Artist.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map { | artist | Artist.new(artist) }
  end

  def Artist.find(id)
    sql = "SELECT * FROM artists WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql, values)
    found_artist = Artist.new(result[0])
    return nil if found_artist == nil
    return found_artist
  end

  def update
    sql = "
      UPDATE artists SET (
        name
      ) =
      (
        $1
      )
      WHERE id = $2
      RETURNING *
    "
    values = [@name, @id]
    result = SqlRunner.run(sql, values)
    updated_artist = Artist.new(result[0])
    return updated_artist
  end

  def Artist.delete_all
    sql = "DELETE FROM artists"
    SqlRunner.run(sql)
  end

  def albums
    sql = "SELECT * FROM albums
          WHERE artist_id = $1"
    values = [@id]
    albums_list = SqlRunner.run(sql, values)
    albums = albums_list.map{ |album_list| Album.new(album_list) }
    return albums
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

end
