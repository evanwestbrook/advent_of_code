def parse_input(file)
  File.readlines(file).each do |row|
    instructions = row.gsub("\n", '')
    instructions = instructions.split(",")
    @x_range = instructions[0].split("x=")[1].split("..").map { |s| s.to_i}
    @y_range = instructions[1].split("y=")[1].split("..").map { |s| s.to_i}
  end
end

def step(coords, velocity)
end

def step_x(x_coord, x_velocity)
  return { x_coord: x_coord + x_velocity, x_velocity: x_velocity -= 1 }
end

parse_input('test_input.txt')
p @x_range
p @y_range
puts step_x(0, 7)