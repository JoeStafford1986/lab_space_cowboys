require('pry')
require_relative('models/bounty')

bounty1 = Bounty.new({
  "name" => "Euan Bell",
  "bounty_value" => "10",
  "last_known_location" => "Dalgety Bay",
  "favourite_weapon" => "whip"
})
bounty1.save()

bounty2 = Bounty.new ({
  "name" => "Jo Malo",
  "bounty_value" => "20",
  "last_known_location" => "Stockbridge",
  "favourite_weapon" => "cutlass"
})
bounty2.save()

binding.pry
nil
