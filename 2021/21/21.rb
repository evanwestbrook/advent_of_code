require './player.rb'
require './deterministic_die.rb'

def play_deterministic_game
  $END_SCORE = 1000
  die = DeterministicDie.new(100)
  player1 = Player.new(4)
  player2 = Player.new(8)

  loser = ""

  loop do
    player1.take_turn(die)
    if player1.score >= $END_SCORE
      puts "Player 1 wins"
      loser = player2
      break
    end
    player2.take_turn(die)
    if player2.score >= $END_SCORE
      puts "Player 2 wins"
      loser = player1
      break
    end
  end

  puts "Loser Score:#{loser.score}"
  puts "Die rolls:#{die.num_rolls}"
  puts "Solution:#{loser.score * die.num_rolls}"
end

play_deterministic_game
