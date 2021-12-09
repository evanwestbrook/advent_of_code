# low points = locations lower than all adjacent locations (up, down, left, right, or edges have 3)
# risk level = low point height + 1

@rows = []
@low_points = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    puts "row: #{row}"
    row_heights = []
    if index == read_file.length - 1
      (row.length).times do |i|
        puts row[i].to_i
        row_heights << row[i].to_i
      end
    else
      (row.length - 1).times do |i|
        puts row[i].to_i
        row_heights << row[i].to_i
      end
    end

    @rows << row_heights
  end
end

def get_left(row_index, col_index)
  return @rows[row_index][col_index - 1]
end

def get_right(row_index, col_index)
  return @rows[row_index][col_index + 1]
end

def get_top(row_index, col_index)
  return @rows[row_index - 1][col_index]
end

def get_bottom(row_index, col_index)
  puts "#{row_index} #{col_index} #{@rows[row_index + 1][col_index]}"
  return @rows[row_index + 1][col_index]
end

def check_top_row(height, row_index, col_index)
  puts "height: #{height}"
  if col_index == 0
    right = get_right(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "right: #{right} bottom: #{bottom}"

    if height < right && height < bottom
      @low_points << height
    end

  elsif col_index == (@rows[row_index].length - 1)
    left = get_left(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "left: #{left} bottom: #{bottom}"

    if height < left && height < bottom
      @low_points << height
    end
  else
    left = get_left(row_index, col_index)
    right = get_right(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "left: #{left} right: #{right} bottom: #{bottom}"

    if height < left && height < right && height < bottom
      @low_points << height
    end
  end
end

def check_mid_row(height, row_index, col_index)
  puts "height: #{height}"
  puts "Row index: #{row_index}, Col index: #{col_index}, End index: #{@rows[row_index].length}"
  if col_index == 0
    right = get_right(row_index, col_index)
    top = get_top(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "right: #{right} top: #{top} bottom: #{bottom}"

    if height < right && height < top && height < bottom
      @low_points << height
    end

  elsif col_index == (@rows[row_index].length - 1)
    left = get_left(row_index, col_index)
    top = get_top(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "left: #{left} top: #{top} bottom: #{bottom}"

    if height < left && height < top && height < bottom
      @low_points << height
    end
  else
    left = get_left(row_index, col_index)
    right = get_right(row_index, col_index)
    top = get_top(row_index, col_index)
    bottom = get_bottom(row_index, col_index)

    puts "left: #{left} right: #{right} top: #{top} bottom: #{bottom}"

    if height < left && height < right && height < top && height < bottom
      @low_points << height
    end
  end
end

def check_last_row(height, row_index, col_index)
  puts "height: #{height}"
  if col_index == 0
    right = get_right(row_index, col_index)
    top = get_top(row_index, col_index)

    puts "right: #{right} top: #{top}"

    if height < right && height < top
      @low_points << height
    end

  elsif col_index == (@rows[row_index].length - 1)
    left = get_left(row_index, col_index)
    top = get_top(row_index, col_index)

    puts "left: #{left} top: #{top}"

    if height < left && height < top
      @low_points << height
    end
  else
    left = get_left(row_index, col_index)
    right = get_right(row_index, col_index)
    top = get_top(row_index, col_index)

    puts "left: #{left} right: #{right} top: #{top}"

    if height < left && height < right && height < top
      @low_points << height
    end
  end
end

def check_low_point(height, row_index, col_index)
  if row_index == 0
    check_top_row(height, row_index, col_index)
  elsif row_index == @rows.length - 1
    check_last_row(height, row_index, col_index)
  else
    check_mid_row(height, row_index, col_index)
  end
end

def find_row_low_points(row, row_index)
  row.each_with_index do |col, index|
    check_low_point(col, row_index, index)
  end
end

def find_low_points
  @rows.each_with_index do |row, index|
    puts "Index: #{index}"
    puts "Row: #{row}"
    find_row_low_points(row, index)
  end
end

def calc_risk_level
  risk_level = 0

  @low_points.each do |height|
    risk_level += height + 1
  end

  return risk_level
end

parse_input('input.txt')
#find_row_low_points(@rows[2], 2)

find_low_points
puts "#{@low_points}"
puts "#{calc_risk_level}"
#puts "Row: #{@rows[99].length}"

#Row index: 98, Col index: 99, End index: 100
#98 99
#left: 9 top: 9 bottom:
#Index: 98
#Row: [2, 1, 2, 3, 4, 5, 6, 7, 9, 8, 8, 8, 9, 4, 3, 1, 2, 3, 4, 9, 8, 9, 9, 9, 8, 4, 3, 2, 1, 4, 3, 4, 5, 6, 9, 8, 9, 8, 9, 7, 6, 9, 5, 4, 0, 1, 2, 3, 4, 5, 9, 5, 4, 3, 4, 9, 8, 7, 6, 5, 4, 3, 2, 1, 2, 3, 4, 5, 9, 9, 1, 2, 3, 4, 5, 6, 7, 9, 8, 5, 4, 8, 8, 9, 8, 7, 6, 5, 4, 5, 6, 7, 8, 9, 2, 3, 9, 8, 9, 2]

