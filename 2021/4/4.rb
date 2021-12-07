def parse_file(file)
  read_file = File.readlines(file)

  @boards = []

  board = []

  read_file.each_with_index do |line, index|
    # Extract numbers to be drawn
    if index == 0
      @draw_numbers = line.split(',')
    end

    # Extract and parse board matrices for rows
    if index > 1
      if line == "\n"
        save_board({ rows: board })
        board = []
      elsif index == read_file.length - 1
        board << line.split(" ")
        save_board({ rows: board })
      else
        board << line.split(" ")
      end
    end
  end
end

def save_board(board)
  board[:columns] = transpose_row_to_columns(board)
  @boards << board
end

def transpose_row_to_columns(board)
  columns = []
  master_index = 0

  board[:rows].each_with_index do |row, index|
    row.each_with_index do |value, index|
      if master_index == 0
        columns << []
      end
      columns[index] << value
    end
    master_index += 1
  end
  return columns
end

def has_match (eval_arr, solution_arr)
  (eval_arr - solution_arr).empty?
end

def find_winner(boards)
  winning_nums = []
  @draw_numbers.each_with_index do |number, index|
    if index > 4
      boards.each do |board|
        board[:rows].each do |row|
          if has_match(row, winning_nums)
            return {board: board, winning_nums: winning_nums}
          end
        end
      end
      winning_nums << number
    else
      winning_nums << number
    end
  end
end

def sum_array(array)
  sum = 0
  array.each do |i|
    sum += i.to_i
  end
  return sum
end

def score_board(board, winning_nums)
  score = 0
  board[:rows].each do |row|
    row_scoreable = row - winning_nums
    score += sum_array(row_scoreable)
  end

  return score
end

parse_file('test_input.txt')

puts @boards

#winner_info = find_winner(@boards)
#board_score = score_board(winner_info[:board], winner_info[:winning_nums])
#winning_score = board_score * winner_info[:winning_nums][-1].to_i
#puts "Winning Score: #{winning_score}"
#puts "Winning Number: #{winner_info[:winning_nums][-1]}"
#puts "Winning Board Score: #{board_score}"
