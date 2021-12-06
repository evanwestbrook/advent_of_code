@position = {
  horizontal: 0,
  depth: 0,
  aim: 0
}

def parse_file(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    parsed_line = line.split
    dict = {command: parsed_line[0], unit: parsed_line[1].to_i}
    @array << dict
  end
end

def forward (unit)
  @position[:horizontal] += unit
end

def down (unit)
  @position[:depth] += unit
end

def up (unit)
  @position[:depth] -= unit
end

def plot_course
  @array.each do |command|
    if command[:command] == "forward"
      forward (command[:unit])
    elsif command[:command] == "down"
      down (command[:unit])
    elsif command[:command] == "up"
      up (command[:unit])
    end
  end
end

parse_file('test_input.txt')
plot_course
puts "Horizontal position: #{@position[:horizontal]}. Depth: #{@position[:depth]}. Multiply: #{@position[:horizontal] * @position[:depth]}."
