require('pg')

class Bounty

  attr_accessor :name, :bounty_value, :last_known_location, :favourite_weapon

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @bounty_value = options["bounty_value"].to_i
    @last_known_location = options["last_known_location"]
    @favourite_weapon = options["favourite_weapon"]
  end

  #instance methods

  def save()
    db = PG.connect({
      dbname: "bounty_tracking",
      host: "localhost"
      })
    sql = "INSERT INTO bounties
      (name,
      bounty_value,
      last_known_location,
      favourite_weapon)
      VALUES
      ($1, $2, $3, $4) RETURNING id"
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: "bounty_tracking",
      host: "localhost"
      })
    sql = "DELETE FROM bounties
    WHERE id = $1"
    db.prepare("delete", sql)
    db.exec_prepared("delete", [@id])
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "bounty_tracking",
      host: "localhost"
      })
    sql = "UPDATE bounties
    SET (name, bounty_value, last_known_location, favourite_weapon) = ($1, $2, $3, $4)
    WHERE id = $5"
    values = [@name, @bounty_value, @last_known_location, @favourite_weapon, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  #Class methods

  def Bounty.all()
    db = PG.connect({
      dbname: "bounty_tracking",
      host: "localhost"
      })
    sql = "SELECT * FROM bounties"
    db.prepare("all", sql)
    bounty_hashes = db.exec_prepared("all")
    db.close()
    bounties = bounty_hashes.map { |bounty_hash| Bounty.new(bounty_hash) }
    return bounties
  end

  def Bounty.delete_all()
  db = PG.connect({
    dbname: "bounty_tracking",
    host: "localhost"
    })
  sql = "DELETE FROM bounties"
  db.prepare("delete_all", sql)
  db.exec_prepared("delete_all")
  db.close()
end

end
