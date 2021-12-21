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

  def take_turn_dirac(die, turn_num, board_options, locations)

    if turn_num < 3
      dice = die.roll
      orig_pos = @position

      dice.each do |die|
        new_pos = move(die.value)
        if @player_num == 0
          player1 = Player.new(new_pos, @score + new_pos, @player_num)
          if player1.score >= $END_SCORE

            $PLAYER_1_WINS += 1
            # Remove winning game
            board_options[player1.position.to_s + "_" + locations[1].to_s] -= 1
          else
            # Update state
            board_options[player1.position.to_s + "_" + locations[1].to_s] += 1

            player1.take_turn_dirac(die, turn_num + 1, board_options, [player1.position, locations[1].to_i])
          end
        elsif @player_num == 1
          player2 = Player.new(new_pos, @score + new_pos, @player_num)
          if player2.score >= $END_SCORE

            $PLAYER_2_WINS += 1
            # Remove winning game
            board_options[locations[0].to_s + "_" + player2.position.to_s] -= 1
          else
            # Update state
            board_options[locations[0].to_s + "_" + player2.position.to_s] += 1

            player2.take_turn_dirac(die, turn_num + 1, board_options, [locations[0].to_i, player2.position])
          end
        end
      end

      # Remove current state
      if @player_num == 0

        board_options[orig_pos.to_s + "_" + locations[1].to_s] -= 1
      elsif @player_num == 0
        board_options[locations[0].to_s + "_" + orig_pos.to_s] -= 1
      end
    end
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
