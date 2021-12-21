require './player.rb'
require './deterministic_die.rb'
require './dirac_die.rb'

def create_dirac_combos(starting1, starting2)
  combo_hash = {}

  10.times do |i|
    10.times do |j|
      combo_hash[(i + 1).to_s + "_" + (j + 1).to_s] = 0
    end
  end

  first = starting1.to_s + "_" + starting2.to_s
  combo_hash[first] = 1

  return combo_hash
end

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
  puts "dirac"
  $END_SCORE = 21
  $PLAYER_1_WINS = 0
  $PLAYER_2_WINS = 0

  board_options = create_dirac_combos(4, 8)
  universes = board_options.select{ |key, value| value > 0 }

  p universes

  universes.each do |key, value|
    locations = key.split("_")
    die = DiracDie.new(1)
    player1 = Player.new(locations[0].to_i, 0, 0)
    player2 = Player.new(locations[1].to_i, 0, 1)

    player1.take_turn_dirac(die, 0, board_options, locations)
    player2.take_turn_dirac(die, 0, board_options, locations)

    #board_options[key] -= 1
    break

  end

  p board_options.select{ |key, value| value > 0 }
  p $PLAYER_1_WINS
  p $PLAYER_2_WINS

end

#play_deterministic_game

play_dirac_game

