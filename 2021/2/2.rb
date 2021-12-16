require './submarine.rb'

@array = File.readlines('test_input.txt').collect do |line|
  line = line.gsub("\n", '').split
  {command: line[0], unit: line[1].to_i}
end

my_sub = Submarine.new(0, 0, 0)

def plot_course(submarine)
  @array.each do |command|
    if command[:command] == "forward"
      submarine.forward(command[:unit])
    elsif command[:command] == "down"
      submarine.down(command[:unit])
    elsif command[:command] == "up"
      submarine.up(command[:unit])
    end
  end
end

plot_course(my_sub)
my_sub.print_coords
