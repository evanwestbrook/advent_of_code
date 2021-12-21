require './player.rb'
require './deterministic_die.rb'

die = DeterministicDie.new
player1 = Player.new(3)
player2 = Player.new(10)

def play_game(die, player1, player2)
  loser = ""

  loop do
    player1.take_turn(die)
    if player1.score >= 1000
      puts "Player 1 wins"
      loser = player2
      break
    end
    player2.take_turn(die)
    if player2.score >= 1000
      puts "Player 2 wins"
      loser = player1
      break
    end
  end

  puts "Loser Score:#{loser.score}"
  puts "Die rolls:#{die.num_rolls}"
  puts "Solution:#{loser.score * die.num_rolls}"
end

play_game(die, player1, player2)
