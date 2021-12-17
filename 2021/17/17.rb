require './probe.rb'

# Start at lowest height we could be at (with the minimum x?)
# keep backing off x and increasing y until we miss
# one right before that will be the solution

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
    return { hit: false }
  end
end

def find_starting_x
  velocity = [1,0]

  loop do
    if fire_probe(velocity)[:hit]
      return velocity
    else
      velocity = [velocity[0] + 1, velocity[1]]
    end
  end
end

def find_max_y_velocity
  #starting_x = 0 - @y_range.max + 1
  velocity = find_starting_x

  loop do
    probe_results = fire_probe(velocity)
    if probe_results[:hit]
      velocity = [velocity[0], velocity[1] + 1]
    else
      return [velocity[0], velocity[1] - 1]
    end
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
puts "X range: #{@x_range}"
puts "Y range: #{@y_range}"
max_velocity = find_max_y_velocity
puts find_starting_x

puts "Velocity for max y: #{max_velocity}"
puts "The max y for this velocity is: #{fire_probe(max_velocity)[:probe].max_y}"
