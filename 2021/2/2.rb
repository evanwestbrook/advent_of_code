def parse_file(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    parsed_line = line.split
    dict = {command: parsed_line[0], unit: parsed_line[1]}
    puts dict
    @array << dict
  end
end

parse_file('test_input.txt')
puts @array