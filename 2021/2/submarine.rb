class Submarine
  def initialize(horizontal, depth, aim)
    @horizontal = horizontal
    @depth = depth
    @aim = aim
  end

  def print_coords
    puts "Horizontal position: #{@horizontal}"
    puts "Depth: #{@depth}"
    puts "Multiply: #{@horizontal * @depth}"
  end

  def forward(unit)
    @horizontal += unit
    @depth += unit * @aim
  end

  def down(unit)
    @aim += unit
  end

  def up(unit)
    @aim -= unit
  end
end
