# gamma rate is most common bit
# epsilon rate is least commit bit. Can just be the reverse of gamma

def parse_file(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    puts line
  end
end

parse_file('test_input.txt')
