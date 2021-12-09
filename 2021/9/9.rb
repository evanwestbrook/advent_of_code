# low points = locations lower than all adjacent locations (up, down, left, right, or edges have 3)
# risk level = low point height + 1

@rows = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    row_heights = []
    row.length.times do |i|
      row_heights << row[i].to_i
    end

    @rows << row_heights
  end
end

parse_input('test_input.txt')

puts "#{@rows}"
