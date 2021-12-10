@lines = []
@corrupted_lines = []
@incomplete_lines = []
@incomplete_scores = []
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

@incomplete_char_scores = {
  ")": 1,
  "]": 2,
  "}": 3,
  ">": 4
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

def check_line_corruption(line)
  opening_stack = []

  line.each_with_index do |character, index|
    if @valid_chars[character.to_sym]
      # Add to opening_stack if it is an opening character
      opening_stack << character
    else
      # Evalute the closing character
      if character != @valid_chars[opening_stack[-1].to_sym]
        # If closing character does not match the most recent open character the line is corrupted
        return { corrupted: true, illegal_char: character, remaining_char: nil}
      else
        # If closing character matches, remove its valid matching character from consideration
        opening_stack.pop()
      end
    end
  end

  # Handle incomplete lines
  return { corrupted: false, illegal_char: nil, remaining_char: opening_stack}
end

def evaluate_lines_corruption(lines)
  lines.each do |line|
    line_corruption_status = check_line_corruption(line)
    if line_corruption_status[:corrupted]
      @corrupted_lines << line_corruption_status
    else
      @incomplete_lines << line_corruption_status
    end
  end
end

def score_corrupted_lines(corrupted_lines)
  score = 0
  corrupted_lines.each do |corrupted_line|
    score += @illegal_char_scores[corrupted_line[:illegal_char].to_sym]
  end

  return score
end

def score_incomplete_line(incomplete_line)
  score = 0

  # Reverse through characters needing to be closed
  incomplete_line[:remaining_char].reverse().each do |character|
    # Look up the valid closing character and its corresponding score
    score = score * 5 + @incomplete_char_scores[@valid_chars[character.to_sym].to_sym]
  end

  return score
end

def score_incomplete_lines(incomplete_lines)
  incomplete_lines.each do |incomplete_line|
    @incomplete_scores << score_incomplete_line(incomplete_line)
  end
end

parse_input('input.txt')

evaluate_lines_corruption(@lines)
puts "Total sytax error score: #{score_corrupted_lines(@corrupted_lines)}"

score_incomplete_lines(@incomplete_lines)
puts "Middle incomplete score: #{@incomplete_scores.sort()[(@incomplete_scores.length + 1) / 2 - 1]}"
