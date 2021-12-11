# Energy level 0 to 9
# Each step:
# 1. Energy level += 1
# 2. Energy level > 9 flashes
#    a. energy level adjacent (including diag) +=1
#    b. This can propogate if it causes others to flash
#    c. Energy = 0
# Problem: after 100 steps, how many flashes?

require './cardinal_directions.rb'

@rows = []
@numflashes = 0
@flashes = {}

def print_grid
  @rows.each do |row|
    row_string = ""
    row.each do |col|
      row_string += col.to_s
    end
    puts row_string
  end
end

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

def step(energy, row_index, col_index)
  #puts "Starting energy: #{energy}"

  if !@flashes[row_index.to_s + "_" + col_index.to_s]
    energy += 1
    @rows[row_index][col_index] = energy
  end

  if @rows[row_index][col_index] > 9
    # Handle flashing
    #puts "flash"
    # Initialize flashes
    # In this recursive scenario, we keep track of the points we have already considered in our basin.
    #   In this manner, we do not re-evaluate points that we have already considered.

    handle_flash(@rows[row_index][col_index], row_index, col_index)
    puts "flashes: #{@flashes}"
  end
end

def handle_flash(energy, row_index, col_index)
  # Add coordinates to the flashes already handled by this flash and reset energy levels for next flash
  @flashes[row_index.to_s + "_" + col_index.to_s] = energy
  @rows[row_index][col_index] = 0
  #puts flashes
  #puts "Ending energy: #{0}"
  @numflashes += 1
  flash(row_index, col_index)
end

def process_adjacent(adjacent_energy, row_index, col_index)
  if adjacent_energy < 99
    if adjacent_energy > 9
      handle_flash(adjacent_energy, row_index, col_index)
    else
      # do not process if flashed this step already
      if !@flashes[row_index.to_s + "_" + col_index.to_s]
        step(adjacent_energy, row_index, col_index)
      end
    end
  end
end

def flash(row_index, col_index)

  # Recursively evalute potential flashes
  process_adjacent(get_adjacent(row_index, col_index)[:w], row_index, col_index - 1)
  process_adjacent(get_adjacent(row_index, col_index)[:e], row_index, col_index + 1)
  process_adjacent(get_adjacent(row_index, col_index)[:n], row_index - 1, col_index)
  process_adjacent(get_adjacent(row_index, col_index)[:s], row_index + 1, col_index)
  process_adjacent(get_adjacent(row_index, col_index)[:nw], row_index - 1, col_index - 1)
  process_adjacent(get_adjacent(row_index, col_index)[:ne], row_index - 1, col_index + 1)
  process_adjacent(get_adjacent(row_index, col_index)[:sw], row_index + 1, col_index - 1)
  process_adjacent(get_adjacent(row_index, col_index)[:se], row_index + 1, col_index + 1)
end

def process_row(row, row_index)
  row.each_with_index do |col, index|
    #puts col
    step(col, row_index, index)
    #check_point(col, row_index, index)
  end
  #print_grid
end

def process_rows
  @rows.each_with_index do |row, index|
    puts "Row ##{index}"
    print_grid

    process_row(row, index)
  end
end

def process_steps(num_steps)
  num_steps.times do |num_step|
    puts "----- Step ##{num_step} -----"
    @flashes = {}
    process_rows
  end
end

puts "----- STARTING -----"
parse_input('test_input_2.txt')
#puts "#{@rows}"
#puts get_adjacent(1, 1)
#puts "Step 1"
#step(@rows[0][2], 0, 2)
#puts "Step 2"
#step(@rows[0][2], 0, 2)

process_steps(2)
puts "# of flashes: #{@numflashes}"