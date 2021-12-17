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
      #puts "Hit with:"
      #probe.print_info
      return true
      #break
    end
  end

  if !probe.inbounds?(@x_range, @y_range)
    #puts "Miss with: "
    #probe.print_info
    return false
  end
end

def find_max_y_velocity
  starting_x = 0 - @y_range[1] + 1
  #puts starting_x
  go = true
  velocity = [starting_x, 0]

  loop do
    if fire_probe(velocity)
      velocity = [velocity[0], velocity[1] + 1]
    else
      #go =  false
      return [velocity[0], velocity[1] - 1]
    end

  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')

puts "Velocity for max y: #{find_max_y_velocity}"
