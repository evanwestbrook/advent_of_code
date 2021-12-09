# low points = locations lower than all adjacent locations (up, down, left, right, or edges have 3)
# risk level = low point height + 1
# basin = any area with an adjoining area going down that's not 9. Probably needs recursion
# Had to adjust length b/c of new lines

@rows = []
@low_points = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    row_heights = []
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

# Return 99 instead of nil because max height will be 9
def get_left(row_index, col_index)
  if (col_index - 1) < 0
    return 99
  else
    return @rows[row_index][col_index - 1]
  end
end

def get_right(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1
    return 99
  else
    return @rows[row_index][col_index + 1]
  end
end

def get_top(row_index, col_index)
  if (row_index - 1) < 0
    return 99
  else
    return @rows[row_index - 1][col_index]
  end
end

def get_bottom(row_index, col_index)
  if row_index + 1 > @rows.length - 1
    return 99
  else
    return @rows[row_index + 1][col_index]
  end
end

def update_low_points(height, row_index, col_index)
  @low_points << {height: height, row_index: row_index, col_index: col_index}
end

def check_row(height, row_index, col_index)
  left = get_left(row_index, col_index)
  right = get_right(row_index, col_index)
  top = get_top(row_index, col_index)
  bottom = get_bottom(row_index, col_index)

  if height < left && height < right && height < top && height < bottom
    update_low_points(height, row_index, col_index)
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

def evaluate_basin(low_point)
  puts low_point
  right = get_right(low_point[:row_index], low_point[:col_index])
  puts right
  left = get_left(low_point[:row_index], low_point[:col_index])
  puts left
  top = get_top(low_point[:row_index], low_point[:col_index])
  puts top
  bottom = get_bottom(low_point[:row_index], low_point[:col_index])
  puts bottom

end


parse_input('test_input.txt')
find_low_points
#puts "#{@low_points}"

#evaluate_basin(@low_points[0])

puts "Risk level: #{calc_risk_level}"
