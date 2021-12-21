class DiracDie
  attr_accessor :value
  def initialize (value)
    @value = value
  end

  def roll
    dice = [
      DiracDie.new(1),
      DiracDie.new(2),
      DiracDie.new(3)
    ]

    return dice
  end
end
