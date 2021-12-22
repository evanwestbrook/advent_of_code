class Player
  attr_accessor :position, :score, :player_num
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

  def take_turn_dirac(to_move)
    @position = move(to_move)
    @score += @position
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
