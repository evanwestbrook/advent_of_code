# split into array
# count frequency of each character
# character that is not even is corrupted?
# Basically a palindrome search problem?
# Store opens in an array. When close is encountered start popping matching opens out of array. If we don't get a match 1st try thats corrupted

@lines = []
@valid_chars = {
  "(": ")",
  "[": "]",
  "{": "}",
  "<": ">"
}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |line|
    # Remove new line character
    line = line.gsub("\n", '')

    # Convert line content to array
    line_array = []
    line.length.times do |i|
      line_array << line[i]
    end

    @lines << line_array

  end
end

parse_input('test_input.txt')
puts "#{@lines}"
puts "#{@valid_chars}"
