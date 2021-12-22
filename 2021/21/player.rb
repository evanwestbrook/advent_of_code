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
    return (@position + to_move - 1) % 10 + 1
  end
end
