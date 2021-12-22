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

def count_wins_2(player, player1, player2)

  if check_score(player1, player2)
    return check_score(player1, player2)
  end

  wins = [0, 0]

  @dirac_rolls.each do |roll|
    if player.player_num == 0
      player1.take_turn_dirac(roll.sum())
      new_player = Player.new(player1.position, player1.score, 0)
      count_res = count_wins(player2, new_player, player2)
    else
      player2.take_turn_dirac(roll.sum())
      new_player = Player.new(player2.position, player2.score, 1)
      count_res = count_wins(player1, player1, new_player)
    end

    wins[0] += count_res[0]
    wins[1] += count_res[1]
  end

  p wins


  return wins
end

def check_score(player1, player2)
  if player1.score >= 21
    return [1, 0]
  elsif player2.score >= 21
    return [1, 0]
  end
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
  @dirac_rolls = get_dirac_rolls
  @won = [0, 0]

  player1 = Player.new(10, 0, 0)
  player2 = Player.new(4, 0, 1)
  wins = count_wins(player1, player1, player2)
  p wins
  p wins.max()
end


def play(pos, score, roll)
  new_pos = ((pos - 1 + roll) % 10) + 1
  new_score = score + new_pos
  return new_pos, new_score
end

# The following is from this solution but did not work well for me
#https://www.reddit.com/r/adventofcode/comments/rl6p8y/2021_day_21_solutions/hph4r3k/?utm_source=share&utm_medium=web2x&context=3
def count_wins(player, pos0, score0, pos1, score1)
  if score0 >= 21
    return 1, 0
  elsif score1 >= 21
    return 0, 1
  end

  wins = [0,0]

  @dirac_rolls.each do |key, value|
    @i +=1
    p @i
    if player == 0
      new_pos, new_score = play(pos0, score0, key.to_i)
      wins0, wins1 = count_wins(1, new_pos, new_score, pos1, score1)
    else
      new_pos, new_score = play(pos1, score1, key.to_i)
      wins0, wins1 = count_wins(0, pos0, score0, new_pos, new_score)
    end

    wins[0] += wins0
    wins[1] += wins1
  end

  return wins
end

@dirac_rolls = get_dirac_rolls

p @dirac_rolls

@i = 0

p count_wins(0, 10, 0, 4, 0)
