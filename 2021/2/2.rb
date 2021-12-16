@position = {
  horizontal: 0,
  depth: 0,
  aim: 0
}

def forward (unit)
  @position[:horizontal] += unit
  @position[:depth] += unit * @position[:aim]
end

def down (unit)
  @position[:aim] += unit
end

def up (unit)
  @position[:aim] -= unit
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

@array = File.readlines('test_input.txt').collect do |line|
  line = line.gsub("\n", '').split
  {command: line[0], unit: line[1].to_i}
end

plot_course
puts "Horizontal position: #{@position[:horizontal]}. Depth: #{@position[:depth]}. Multiply: #{@position[:horizontal] * @position[:depth]}."
