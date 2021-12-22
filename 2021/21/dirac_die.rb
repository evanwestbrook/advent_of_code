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

  def get_dirac_rolls
    # Method to get the count for all possible sums of a dice rol
    rolls = []

    dice = self.roll
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
end
