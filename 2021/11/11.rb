# Energy level 0 to 9
# Each step:
# 1. Energy level += 1
# 2. Energy level > 9 flashes
#    a. energy level adjacent (including diag) +=1
#    b. This can propogate if it causes others to flash
#    c. Energy = 0
# Problem: after 100 steps, how many flashes?

@rows = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')

    # Convert line content to array
    row_array = []
    row.length.times do |i|
      row_array << row[i].to_i
    end

    @rows << row_array
  end
end

def get_w(row_index, col_index)
  if (col_index - 1) < 0 # handle left boundary
    return 99
  else
    return @rows[row_index][col_index - 1]
  end
end

def get_e(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1  # handle right boundary
    return 99
  else
    return @rows[row_index][col_index + 1]
  end
end

def get_n(row_index, col_index)
  if (row_index - 1) < 0 # handle top boundary
    return 99
  else
    return @rows[row_index - 1][col_index]
  end
end

def get_s(row_index, col_index)
  if row_index + 1 > @rows.length - 1  # handle bottom boundary
    return 99
  else
    return @rows[row_index + 1][col_index]
  end
end

def get_nw(row_index, col_index)
  if (col_index - 1) < 0 || (row_index - 1) < 0 # handle left and top boundary
    return 99
  else
    return @rows[row_index - 1][col_index - 1]
  end
end

def get_ne(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1 || (row_index - 1) < 0 # handle right and top boundary
    return 99
  else
    return @rows[row_index - 1][col_index + 1]
  end
end

def get_sw(row_index, col_index)
  if (col_index - 1) < 0 || row_index + 1 > @rows.length - 1 # handle left and bottom boundary
    return 99
  else
    return @rows[row_index + 1][col_index - 1]
  end
end

def get_se(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1 || row_index + 1 > @rows.length - 1 # handle right and bottom boundary
    return 99
  else
    return @rows[row_index + 1][col_index + 1]
  end
end

def get_adjacent(row_index, col_index)
  return {
    w: get_w(row_index, col_index),
    e: get_e(row_index, col_index),
    n: get_n(row_index, col_index),
    s: get_s(row_index, col_index),
    nw: get_nw(row_index, col_index),
    ne: get_ne(row_index, col_index),
    sw: get_sw(row_index, col_index),
    se: get_se(row_index, col_index)
  }
end

def step(energy, row_index, col_index)
  puts "Starting energy: #{energy}"
  if energy >= 9
    # Handle flashing
    puts "flash"
    # Initialize flashes
    # In this recursive scenario, we keep track of the points we have already considered in our basin.
    #   In this manner, we do not re-evaluate points that we have already considered.
    basin = {}
    basin[low_point[:row_index].to_s + "_" + low_point[:col_index].to_s] = low_point[:height]
  else
    energy += 1
    @rows[row_index][col_index] = energy
  end
  puts "Ending energy: #{energy}"
end

def flash(flashes, energy)
end

puts "----- STARTING -----"
parse_input('test_input.txt')
#puts "#{@rows}"
#puts get_adjacent(1, 1)

step(@rows[0][2], 0, 2)
step(@rows[0][2], 0, 2)