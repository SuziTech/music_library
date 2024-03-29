require('pry')
require_relative('./models/artist')
require_relative('./models/album')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new( { "name" => "coldplay"} )
artist2 = Artist.new( { "name" => "the last poets"} )

artist1.save()
artist2.save()

album1 = Album.new({
  "title" => "greatest hits",
  "genre" => "depressing",
  "artist_id" => artist1.id
  })

album3 = Album.new({
  "title" => "rush of blood to the head",
  "genre" => "mellow",
  "artist_id" => artist1.id
 })

album2 = Album.new({
  "title" => "black summer",
  "genre" => "rap",
  "artist_id" => artist2.id
  })

album4 = Album.new({
  "title" => "new york stories",
  "genre" => "rap",
  "artist_id" => artist2.id
  })

album1.save()
album2.save()
album3.save()
album4.save()

album1.delete()

poets = Artist.find(artist2.id)

binding.pry
nil
