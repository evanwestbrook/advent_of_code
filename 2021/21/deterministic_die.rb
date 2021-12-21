class DeterministicDie
  def initialize
    @value = 0
  end

  def roll
    if @value < 100
      @value += 1
    else
      @value = 1
    end
    return @value
  end
end
