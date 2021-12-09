# low points = locations lower than all adjacent locations (up, down, left, right, or edges have 3)
# risk level = low point height + 1

@rows = []
@low_points = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    row_heights = []
    (row.length - 1).times do |i|
      row_heights << row[i].to_i
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
    puts "mid row"
  end
end

def find_row_low_points(row, row_index)
  puts @rows[row_index].length - 1
  row.each_with_index do |col, index|
    check_low_point(col, row_index, index)
  end
end

def find_low_points
  @rows.each_with_index do |row, index|
  end
end

parse_input('test_input.txt')
#puts "#{@rows}"

find_row_low_points(@rows[0], 0)
puts "#{@low_points}"

