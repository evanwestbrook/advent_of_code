require './player.rb'
require './deterministic_die.rb'
require './dirac_die.rb'

def create_dirac_combos(starting1, starting2)
  combo_hash = {}

  10.times do |i|
    3.times do |j|
      key_val_1 = starting1 + i + 1
      if key_val_1 > 10
        key_val_1 = key_val_1 - 10
      end

      key_val_2 = starting2 + j + 1
      if key_val_2 > 10
        key_val_2 = key_val_2 - 10
      end
      key = key_val_1.to_s + "_" + key_val_2.to_s

      combo_hash[key] = 0
    end
  end

  p combo_hash.length

  10.times do |i|
    3.times do |j|
      key_val_2 = starting1 + i + 1
      if key_val_2 > 10
        key_val_2 = key_val_2 - 10
      end

      key_val_1 = starting1 + j + 1
      if key_val_1 > 10
        key_val_1 = key_val_1 - 10
      end
      key = key_val_1.to_s + "_" + key_val_2.to_s
      combo_hash[key] = 0
    end
  end
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
  $END_SCORE = 21
  $PLAYER_1_WINS = 0
  $PLAYER_2_WINS = 0

  die = DiracDie.new(1)
  player1 = Player.new(4, 0, 0)
  player2 = Player.new(8, 0, 1)

  universes = [{player1: player1, player2: player2}]

  universes.each_with_index do |universe, index|
    break if $PLAYER_2_WINS >= 341960390180808
    universe[:player1].take_turn_dirac(die, 0, universes, universe)
    universe[:player2].take_turn_dirac(die, 0, universes, universe)
    puts "# of universes: #{universes.length}"
    #puts "Player 1 wins #{$PLAYER_1_WINS}"
    #puts "Player 2 wins #{$PLAYER_2_WINS}"
  end
  puts "Player 1 wins #{$PLAYER_1_WINS}"
  puts "Player 2 wins #{$PLAYER_2_WINS}"

end

p create_dirac_combos(4, 8)


#play_deterministic_game
#play_dirac_game
