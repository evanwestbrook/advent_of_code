@rows = []
@low_points = []
@basins = []
@basin_sizes = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    row_heights = []
    # Handle indexing quirks due to newline characters
    if index == read_file.length - 1
      (row.length).times do |i|
        row_heights << row[i].to_i
      end
    else
      (row.length - 1).times do |i|
        row_heights << row[i].to_i
      end
    end

    @rows << row_heights
  end
end

# Return 99 instead of nil because max height will be 9 and it will be easier to evaluate numbers than nils
def get_left(row_index, col_index)
  if (col_index - 1) < 0 # handle left boundary
    return 99
  else
    return @rows[row_index][col_index - 1]
  end
end

def get_right(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1  # handle right boundary and newline character
    return 99
  else
    return @rows[row_index][col_index + 1]
  end
end

def get_top(row_index, col_index)
  if (row_index - 1) < 0 # handle top boundary
    return 99
  else
    return @rows[row_index - 1][col_index]
  end
end

def get_bottom(row_index, col_index)
  if row_index + 1 > @rows.length - 1  # handle bottom boundary and newline character
    return 99
  else
    return @rows[row_index + 1][col_index]
  end
end

def check_row(height, row_index, col_index)
  left = get_left(row_index, col_index)
  right = get_right(row_index, col_index)
  top = get_top(row_index, col_index)
  bottom = get_bottom(row_index, col_index)

  if height < left && height < right && height < top && height < bottom
    @low_points << { height: height, row_index: row_index, col_index: col_index }
  end
end

def find_row_low_points(row, row_index)
  row.each_with_index do |col, index|
    check_row(col, row_index, index)
  end
end

def find_low_points
  @rows.each_with_index do |row, index|
    find_row_low_points(row, index)
  end
end

def calc_risk_level
  risk_level = 0

  @low_points.each do |low_point|
    risk_level += low_point[:height] + 1
  end

  return risk_level
end

def get_basin(low_point)

  # Initialize basin
  # In this recursive scenario, we keep track of the points we have already considered in our basin.
  #   In this manner, we do not re-evaluate points that we have already considered.
  basin = {}
  basin[low_point[:row_index].to_s + "_" + low_point[:col_index].to_s] = low_point[:height]

  # Start recursively evaluating basin points
  evaluate_point(low_point, basin)

  return basin
end

def evaluate_point(point, basin)
  # Determine initial valid basin points
  left = get_left(point[:row_index], point[:col_index])
  right = get_right(point[:row_index], point[:col_index])
  top = get_top(point[:row_index], point[:col_index])
  bottom = get_bottom(point[:row_index], point[:col_index])

  # Recursively evalute potential basin points
  # In each direction we check:
  #   1. Is this a peak (9) or edge (99)?
  #   2. Have we already evaluated this point
  #     ex: If we are on point = { row_index: 3, col_index: 5, height: 3 }, does it already exist in basin = { 3_5: 3 }
  if get_left(point[:row_index], point[:col_index]) < 9 && !basin[point[:row_index].to_s + "_" + (point[:col_index] - 1).to_s]
    new_point = { height: @rows[point[:row_index]][point[:col_index] - 1], row_index: point[:row_index], col_index: point[:col_index] - 1 }
    basin[new_point[:row_index].to_s + "_" + new_point[:col_index].to_s] = new_point[:height]

    evaluate_point(new_point, basin)
  end
  if get_right(point[:row_index], point[:col_index]) < 9  && !basin[point[:row_index].to_s + "_" + (point[:col_index] + 1).to_s]
    new_point = { height: @rows[point[:row_index]][point[:col_index] + 1], row_index: point[:row_index], col_index: point[:col_index] + 1 }
    basin[new_point[:row_index].to_s + "_" + new_point[:col_index].to_s] = new_point[:height]

    evaluate_point(new_point, basin)
  end
  if get_top(point[:row_index], point[:col_index]) < 9  && !basin[(point[:row_index] - 1).to_s + "_" + point[:col_index].to_s]
    new_point = { height: @rows[point[:row_index] - 1][point[:col_index]], row_index: point[:row_index] - 1, col_index: point[:col_index] }
    basin[new_point[:row_index].to_s + "_" + new_point[:col_index].to_s] = new_point[:height]

    evaluate_point(new_point, basin)
  end
  if get_bottom(point[:row_index], point[:col_index]) < 9  && !basin[(point[:row_index] + 1).to_s + "_" + point[:col_index].to_s]
    new_point = { height: @rows[point[:row_index] + 1][point[:col_index]], row_index: point[:row_index] + 1, col_index: point[:col_index] }
    basin[new_point[:row_index].to_s + "_" + new_point[:col_index].to_s] = new_point[:height]

    evaluate_point(new_point, basin)
  end
end

def get_basins
  @low_points.each do |low_point|
    @basins << get_basin(low_point) # We don't really need to store these basis, but I found it better for debugging
    @basin_sizes << get_basin(low_point).length
  end
end

def get_basin_solution
  solution = 1
  sizes = @basin_sizes.sort().reverse!

  # Handle situations where there are fewer than 3 valid basins
  if @basin_sizes.length > 3
    iterations = 3
  else
    iterations = @basin_sizes.length
  end

  iterations.times do |i|
    solution = sizes[i] * solution
  end

  return solution
end

parse_input('input.txt')

find_low_points
get_basins
puts "Risk level: #{calc_risk_level}"
puts "The solution to part 2 is: #{get_basin_solution}"
