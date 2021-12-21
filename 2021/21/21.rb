require './player.rb'
require './deterministic_die.rb'

die = DeterministicDie.new
player = Player.new(5)

p player.position
player.take_turn(die)
p player.position