require './probe.rb'

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

  loop do
    probe.move
    if probe.hit?(@x_range, @y_range)
      probe.print_info
      break
    end
  end
end

parse_input('test_input.txt')
fire_probe([7,2])
