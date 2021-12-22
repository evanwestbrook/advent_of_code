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

def get_dirac_rolls
  die = DiracDie.new(1)

  rolls = []

  dice = die.roll
  dice.each do |die|
    rolls << [die.value]
  end

  rolls_2 = []
  rolls.each do |roll|
    dice.each do |die|
      rolls_2 << [roll[0], die.value]
    end
  end
  rolls_3 = []
  rolls_2.each do |roll|
    dice.each do |die|
      rolls_3 << [roll[0], roll[1], die.value]
    end
  end

  dirac_sums = {}

  rolls_3.each do |roll|
    roll_sum = roll.sum()
    if dirac_sums[roll_sum]
      dirac_sums[roll_sum] += 1
    else
      dirac_sums[roll_sum] = 1
    end
  end

  return dirac_sums
end

def play_dirac_game
  die = DiracDie.new(1)
  @dirac_rolls =  die.get_dirac_rolls

  player_positions = [3, 10]
  length_dicts = []

  # Get all possibilities for a given number
  player_positions.each do |player_position|
    d = {}
    roll_next(player_position, 0, 0, 1, d)
    length_dicts.append(d)
  end

  won = [0,0]

  length_dicts[0].each do |length1_score1, value1|
    l1s1split = length1_score1.to_s.split("_")
    length1 = l1s1split[0].to_i
    score1 = l1s1split[1].to_i

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
# trying this solution
# https://github.com/HrRodan/adventofcode2021/blob/master/day21/day21_part2.py

def move_player(position, score, steps)
  position_final = (position + steps - 1) % 10 + 1
  return position_final, score + position_final
end

def roll_next(position, score, length, p, length_dict)
  @dirac_rolls.each do |roll_sum, count|
    if score >= 21
      return
    end
    new_position, new_score = move_player(position, score, roll_sum.to_i)
    new_length = length + 1
    p_new = p * count

    if length_dict[new_length.to_s + "_" + new_score.to_s]
      length_dict[new_length.to_s + "_" + new_score.to_s] += p_new
    else
      length_dict[new_length.to_s + "_" + new_score.to_s] = p_new
    end

    roll_next(new_position, new_score, new_length, p_new, length_dict)
  end
end

#play_deterministic_game
play_dirac_game

