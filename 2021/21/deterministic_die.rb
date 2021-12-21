class DeterministicDie
  attr_accessor :num_rolls
  def initialize (num_sides)
    @num_sides = num_sides
    @value = 0
    @num_rolls = 0
  end

  def roll
    @num_rolls += 1
    if @value < @num_sides
      @value += 1
    else
      @value = 1
    end
    return @value
  end
end
