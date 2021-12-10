# split into array
# count frequency of each character
# character that is not even is corrupted?
# Basically a palindrome search problem?
# Store opens in an array. When close is encountered start popping matching opens out of array. If we don't get a match 1st try thats corrupted

@lines = []
@corrupted_lines = []
@valid_chars = {
  "(": ")",
  "[": "]",
  "{": "}",
  "<": ">"
}
@illegal_char_scores = {
  ")": 3,
  "]": 57,
  "}": 1197,
  ">": 25137
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

# On further investigation, I realized that all lines are incomplete. It's just whether they're corrupted or complete
def check_incomplete(lines)
  # Checks to see if the lines are complete
  lines.each do |line|
     puts is_complete_line(line)
  end
end

def is_complete_line(line)
  # Checks to see if a line is complete
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

def check_line_corruption(line)
  opening_stack = []

  line.each_with_index do |character, index|
    puts  "Opening stack: #{opening_stack}"
    if @valid_chars[character.to_sym]
      # Add to opening_stack if it is an opening character
      opening_stack << character
    else
      # Evalute the closing character
      if character != @valid_chars[opening_stack[-1].to_sym]
        # If closing character does not match the most recent open character the line is corrupted
        return { corrupted: true, illegal_char: character}
      else
        # If closing character matches, remove its valid matching character from consideration
        opening_stack.pop()
      end
    end
  end

  # Handle incomplete lines
  return { corrupted: false, illegal_char: nil}
end

def evaluate_lines_corruption(lines)
  lines.each do |line|
    line_corruption_status = check_line_corruption(line)
    if line_corruption_status[:corrupted]
      @corrupted_lines << line_corruption_status
    end
  end
end

parse_input('test_input.txt')

#check_incomplete(@lines)
#puts check_line_corruption(@lines[0])
evaluate_lines_corruption(@lines)
puts @corrupted_lines
