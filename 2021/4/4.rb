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

def evaluate_item(item, winning_nums, board)
  # Exclude last draw because winning on last draw results in score of 0
  if has_match(item, winning_nums) && winning_nums.length != @draw_numbers.length
    if @first_winning_board.empty?
      @first_winning_board = {board: board, winning_nums: winning_nums.dup}
    else
      @latest_winning_board = {board: board, winning_nums: winning_nums.dup}
    end

    # remove board from consideration after it has won
    @boards.delete(board)
  end
end

def find_winners(boards)
  @first_winning_board = {}
  @latest_winning_board = {}

  winning_nums = []
  @draw_numbers.each_with_index do |number, index|
    if index > 4  && @boards.empty? == false
      boards.each_with_index do |board, index|
        board_index = index
        # Check for winning rows
        board[:rows].each do |row|
          evaluate_item(row, winning_nums, board)
        end

        # Check for winning columns
        board[:columns].each do |column|
          evaluate_item(column, winning_nums, board)
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

parse_file('input.txt')
find_winners(@boards)

first_board_score = score_board(@first_winning_board[:board], @first_winning_board[:winning_nums])
first_winning_score = first_board_score * @first_winning_board[:winning_nums][-1].to_i
puts "First Winning Score: #{first_winning_score}"
puts "First Winning Number: #{@first_winning_board[:winning_nums][-1]}"
puts "First Winning Board Score: #{first_board_score}"

latest_board_score = score_board(@latest_winning_board[:board], @latest_winning_board[:winning_nums])
latest_winning_score = latest_board_score * @latest_winning_board[:winning_nums][-1].to_i
puts "Latest Winning Score: #{latest_winning_score}"
puts "Latest Winning Number: #{@latest_winning_board[:winning_nums][-1]}"
puts "Latest Winning Board Score: #{latest_board_score}"
