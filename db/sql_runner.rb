require('pg')

class SqlRunner

  # need sql string we're going to run and the values array
  def self.run(sql, values = [])
    begin
      db = PG.connect({dbname: "music_library", host: "localhost"})
      db.prepare("query", sql)
      result = db.exec_prepared("query", values)
    ensure
      db.close() if db != nil
    end
    return result
  end

end
