require './probe.rb'

# Start at lowest height we could be at (with the minimum x?)
# keep backing off x and increasing y until we miss
# one right before that will be the solution
@hit_velocities = []

def parse_input(file)
  File.readlines(file).each do |row|
    instructions = row.gsub("\n", '')
    instructions = instructions.split(",")
    @x_range = instructions[0].split("x=")[1].split("..").map { |s| s.to_i}
    @y_range = instructions[1].split("y=")[1].split("..").map { |s| s.to_i}
  end
end

def fire_probe(velocity)
  probe = Probe.new([0,0], velocity)

  while probe.inbounds?(@x_range, @y_range)
    probe.move

    if probe.hit?(@x_range, @y_range)
      return { hit: true, probe: probe }
    end
  end

  if !probe.inbounds?(@x_range, @y_range)
    return { hit: false, probe: probe }
  end
end

def find_all_velocities
  find_velocity(0,0)
end


def find_velocity(x, y)
  velocity = [x,y]
  probe = fire_probe(velocity)
  x_coord = probe[:probe].x_coord
  index = 1

  while x_coord < @x_range.max do
    if probe[:hit]
      @hit_velocities << velocity

      explore_x(velocity)
    end
    velocity = [x + index, y]
    probe = fire_probe(velocity)
    x_coord = probe[:probe].x_coord
    index += 1
    explore_x(velocity)
  end
end

def explore_x(velocity)
  increase_velocities_y(velocity)
  decrease_velocities_y(velocity)
end

def increase_velocities_y(velocity)
  inc_v = velocity.dup

  inc_v = [inc_v[0], inc_v[1] + 1]

  loop do
    probe = fire_probe(inc_v)
    if probe[:hit]
      @hit_velocities << inc_v
      inc_v = [inc_v[0], inc_v[1] + 1]
    else
      break
    end
  end
end

def decrease_velocities_y(velocity)
  inc_v = velocity.dup

  inc_v = [inc_v[0], inc_v[1] - 1]

  loop do
    probe = fire_probe(inc_v)
    if probe[:hit]
      @hit_velocities << inc_v
      inc_v = [inc_v[0], inc_v[1] - 1]
    else
      break
    end
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
puts "X range: #{@x_range}"
puts "Y range: #{@y_range}"

find_all_velocities
puts "Hit velocities #{@hit_velocities}"
puts "Hit velocities #{@hit_velocities.length}"
