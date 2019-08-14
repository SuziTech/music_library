require_relative('../db/sql_runner')

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

def Artist.delete_all
  sql = "DELETE FROM artists"
  SqlRunner.run(sql)
end









end
