@horizontal = 0
@depth = 0


def parse_file(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    parsed_line = line.split
    dict = {command: parsed_line[0], unit: parsed_line[1].to_i}
    @array << dict
  end
end

def plot_course
  @array.each do |command|
    if command[:command] == "forward"
      @horizontal += command[:unit]
    elsif command[:command] == "down"
      @depth += command[:unit]
    elsif command[:command] == "up"
      @depth -= command[:unit]
    end
  end
end



parse_file('input.txt')
plot_course
puts "Horizontal position: #{@horizontal}. Depth: #{@depth}. Multiply: #{@horizontal * @depth}."