@rows = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')
    cols = []

    row.length.times do |col|
      cols << row[col]
    end

    @rows << cols
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
puts "#{@rows}"
