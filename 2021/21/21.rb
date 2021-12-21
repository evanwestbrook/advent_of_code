require './player.rb'
require './deterministic_die.rb'
require './dirac_die.rb'

def play_deterministic_game
  $END_SCORE = 1000
  die = DeterministicDie.new(100)
  player1 = Player.new(4, 0, 0)
  player2 = Player.new(8, 0, 1)

  loser = ""

  loop do
    player1.take_turn_deterministic(die)
    if player1.score >= $END_SCORE
      puts "Player 1 wins"
      loser = player2
      break
    end
    player2.take_turn_deterministic(die)
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

def play_dirac_game
  $END_SCORE = 21
  $PLAYER_1_WINS = 0
  $PLAYER_2_WINS = 0

  die = DiracDie.new(1)
  player1 = Player.new(4, 0, 0)
  player2 = Player.new(8, 0, 1)

  universes = [{player1: player1, player2: player2}]

  puts "Staring universes:"
  p universes
  universes[0][:player1].take_turn_dirac(die, 0, universes, universes[0])

  puts "Step 1 universes:"
  p universes
  p universes.length

end

#play_deterministic_game
play_dirac_game
