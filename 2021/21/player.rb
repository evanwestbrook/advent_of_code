class Player
  attr_accessor :position, :score
  def initialize(position, score, player_num)
    @position = position
    @score = score
    @player_num = player_num
  end

  def take_turn_deterministic(die)
    to_move = 0
    3.times do
      to_move += die.roll
    end

    @position = move(to_move)

    @score += @position
  end

  def take_turn_dirac(die, turn_num, universes, universe)
    if turn_num < 3
      dice = die.roll
      dice.each do |die|
        new_pos = move(die.value)
        if @player_num == 0
          universe = { player1: Player.new(new_pos, @score + new_pos, @player_num), player2: universe[:player2] }
          if universe[:player1].score >= $END_SCORE
            $PLAYER_1_WINS += 1
          else
            universes << universe
            universe[:player1].take_turn_dirac(die, turn_num + 1, universes, universe)
          end
        elsif @player_num == 1
          universe = { player1: universe[:player1], player2: Player.new(new_pos, @score + new_pos, @player_num) }
          if universe[:player2].score >= $END_SCORE
            $PLAYER_2_WINS += 1
          else
            universes << universe
            universe[:player2].take_turn_dirac(die, turn_num + 1, universes, universe)
          end
        end
      end
    end

    universes.delete(universe)
  end

  private

  def move(to_move)
    max_position = @position + to_move
    if max_position - (max_position / 10) * 10 == 0
      return 10
    else
      return max_position - (max_position / 10) * 10
    end
  end
end
