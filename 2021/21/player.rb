class Player
  attr_accessor :position, :score
  def initialize(position)
    @position = position
    @score = 0
  end

  def take_turn(die)
    to_move = 0
    3.times do
      to_move += die.roll
    end

    move(to_move)

    @score += @position
  end

  private

  def move(to_move)
    max_position = @position + to_move
    @position = max_position - (max_position / 10) * 10
  end
end
