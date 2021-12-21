class DiracDie
  attr_accessor
  def initialize (num_sides)
    @num_sides = num_sides
    @value = 0
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
