# split into array
# count frequency of each character
# character that is not even is corrupted?
# Basically a palindrome search problem?
# Store opens in an array. When close is encountered start popping matching opens out of array. If we don't get a match 1st try thats corrupted
# Incomplete lines would be lines with no @ least one non-matching character or corrupted lines that dind't find the mismatched value to the end

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

def check_incomplete(lines)
  # Checks to see if the lines are complete
  lines.each do |line|
     puts is_complete_line(line)
  end
end

def is_complete_line(line)
  complete = 0
  @valid_chars.each do |key, value|
    num_open = line.each_index.select { |index| line[index] == key.to_s}.length
    num_closed = line.each_index.select { |index| line[index] == value}.length
    if num_open == num_closed
      complete += 1
    end
  end

  if complete < 4
    return false
  else
    return true
  end
end

parse_input('test_input.txt')

check_incomplete(@lines)
