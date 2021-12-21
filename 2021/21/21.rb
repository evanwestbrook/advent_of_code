require './player.rb'
require './deterministic_die.rb'

die = DeterministicDie.new
player1 = Player.new(4)
player2 = Player.new(8)

puts "P1 Starting position: #{player1.position}"
puts "P1 Starting score: #{player1.score}"
puts "P2 Starting position: #{player2.position}"
puts "P2 Starting score: #{player2.score}"

4.times do |index|
  player1.take_turn(die)
  puts "P1 #{index} position: #{player1.position}"
  puts "P1 #{index} score: #{player1.score}"
  player2.take_turn(die)
  puts "P2 #{index} position: #{player2.position}"
  puts "P2 #{index} score: #{player2.score}"

end
