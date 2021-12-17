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
      puts "Hit with:"
      probe.print_info
      break
    end
  end

  if !probe.inbounds?(@x_range, @y_range)
    puts "Miss with: "
    probe.print_info
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
puts "X range: #{@x_range}"
puts "Y range: #{@y_range}"
fire_probe([6, 0])
