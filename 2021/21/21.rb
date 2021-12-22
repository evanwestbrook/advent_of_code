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

# trying this solution
# https://github.com/HrRodan/adventofcode2021/blob/master/day21/day21_part2.py

def roll_next(player, length, point, length_dict)

  @dirac_rolls.each do |roll_sum, count|
    # Copy so we have distinct player
    my_player = player.dup

    # Log a win or take the turn
    if my_player.score >= 21
      return
    end
    my_player.take_turn_dirac(roll_sum.to_i)

    # Log the score for this player given the # of rolls
    new_length = length + 1
    p_new = point * count

    if length_dict[new_length.to_s + "_" + my_player.score.to_s]
      length_dict[new_length.to_s + "_" + my_player.score.to_s] += p_new
    else
      length_dict[new_length.to_s + "_" + my_player.score.to_s] = p_new
    end

    roll_next(my_player, new_length, p_new, length_dict)
  end
end

def play_dirac_game
  die = DiracDie.new(1)
  @dirac_rolls =  die.get_dirac_rolls

  length_dicts = []

  player1 = Player.new(3, 0, 0)
  player2 = Player.new(10, 0, 1)

  players = [player1, player2]

  # Get all possibilities of scores based on the # of rolls for each player
  players.each do |player|
    d = {}
    roll_next(player, 0, 1, d)
    length_dicts.append(d)
  end

  won = [0,0]

  # For all of player 1 rolls
  length_dicts[0].each do |length1_score1, value1|
    l1s1split = length1_score1.to_s.split("_")
    length1 = l1s1split[0].to_i
    score1 = l1s1split[1].to_i

    # Compare with the corresponding roll for for player 1
    length_dicts[1].each do |length2_score2, value2|
      l2s2split = length2_score2.to_s.split("_")
      length2 = l2s2split[0].to_i
      score2 = l2s2split[1].to_i

      if score1 >= 21 && length2 == length1 - 1 && score2 < 21
        won[0] += value1 * value2
      end
      if score2 >= 21 && length2 == length1 - 1 && score1 < 21
        won[1] += value1 * value2
      end
    end
  end

  puts "The # of universes in which the most player with the most wins wins is #{won.max()}"
end

play_deterministic_game
play_dirac_game

