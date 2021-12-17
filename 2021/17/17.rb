def parse_input(file)
  File.readlines(file).each do |row|
    instructions = row.gsub("\n", '')
    instructions = instructions.split(",")
    @x_range = instructions[0].split("x=")[1].split("..").map { |s| s.to_i}
    @y_range = instructions[1].split("y=")[1].split("..").map { |s| s.to_i}
  end
end

def step(coords, velocity)
  puts "Coodinates: #{coords}"
  puts "Velocity: #{velocity}"
  x_res = step_x(coords[0], velocity[0])
  y_res = step_y(coords[1], velocity[1])
  hit = check_target([x_res[:x_coord], y_res[:y_coord]])
  return {
    coords: [x_res[:x_coord], y_res[:y_coord]],
    velocity: [x_res[:x_velocity], y_res[:y_velocity]],
    hit: hit
  }
end

def step_x(x_coord, x_velocity)

  x_coord += x_velocity

  if x_velocity > 0
    x_velocity -= 1
  end
  return { x_coord: x_coord, x_velocity: x_velocity }
end

def step_y(y_coord, y_velocity)
  y_coord += y_velocity
  return { y_coord: y_coord, y_velocity: y_velocity -= 1 }
end

def check_target(coords)
  if coords[0] >= @x_range[0] && coords[0] <= @x_range[1]
    if coords[1] >= @y_range[0] && coords[1] <= @y_range[1]
      return true
    end
  end

  return false
end

def fire_probe(velocity)
  coords = [0,0]

  loop do
    res = step(coords, velocity)
    if res[:hit]
      p res
      return "hit!"
      break
    else
      coords = res[:coords]
      velocity = res[:velocity]
    end
  end
end

parse_input('test_input.txt')
fire_probe([7,2])