def forward(position, unit)
  position[:horizontal] += unit
  position[:depth] += unit * position[:aim]
end

def down(position, unit)
  position[:aim] += unit
end

def up(position, unit)
  position[:aim] -= unit
end

def plot_course (position)
  @array.each do |command|
    if command[:command] == "forward"
      forward(position, command[:unit])
    elsif command[:command] == "down"
      down(position, command[:unit])
    elsif command[:command] == "up"
      up(position, command[:unit])
    end
  end

  position
end

@array = File.readlines('test_input.txt').collect do |line|
  line = line.gsub("\n", '').split
  {command: line[0], unit: line[1].to_i}
end

starting_position = {
  horizontal: 0,
  depth: 0,
  aim: 0
}

final_position = plot_course(starting_position)
puts "Horizontal position: #{final_position[:horizontal]}. Depth: #{final_position[:depth]}. Multiply: #{final_position[:horizontal] * final_position[:depth]}."
