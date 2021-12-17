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
  starting_velocity = [0 - @y_range.max + 1, 1] # range at which top left is hit
  puts "Starting: velocity #{starting_velocity}"
  @hit_velocities << starting_velocity

  get_velocities(starting_velocity)

  #increase y velocity unitl miss
  #reduce yvelocity until miss
  # increas x velocity and repeat

end

def get_velocities(velocity)
  puts "Velocity: #{velocity}"
  increase_velocities_y(velocity)
  decrease_velocities_y(velocity)

  inc_x_v = velocity.dup
  inc_x_v = [inc_x_v[0] + 1, inc_x_v[1]]
  probe = fire_probe(inc_x_v)
  if probe[:hit]
    @hit_velocities << inc_x_v
    get_velocities(inc_x_v)
  #else
  #elsif probe[:probe].x_coord < @x_range.max
    puts probe[:probe].x_coord
  #  get_velocities(inc_x_v)
  end
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
#puts "Hit velocities #{@hit_velocities}"
#puts "Hit velocities #{@hit_velocities.length}"
puts @x_range.max
