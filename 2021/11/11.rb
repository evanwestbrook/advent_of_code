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

  energy += 1
  @rows[row_index][col_index] = energy

  if @rows[row_index][col_index] > 9
  #if energy >= 9
    # Handle flashing
    #puts "flash"
    # Initialize flashes
    # In this recursive scenario, we keep track of the points we have already considered in our basin.
    #   In this manner, we do not re-evaluate points that we have already considered.

    handle_flash(@rows[row_index][col_index], row_index, col_index)
    #handle_flash(@flashes, energy, row_index, col_index)
    puts "flashes: #{@flashes}"
  #else
  #  energy += 1
  #  @rows[row_index][col_index] = energy
    #puts "Ending energy: #{energy}"
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

def flash(row_index, col_index)
  # Determine valid adjacent energy levels
  adjacent_energy = get_adjacent(row_index, col_index)
  #puts "#{adjacent_energy}"

  # Recursively evalute potential flashes
  if adjacent_energy[:w] < 99
    if adjacent_energy[:w] > 9
      handle_flash(adjacent_energy[:w], row_index, col_index - 1)
    else
      #puts "new energy west: #{adjacent_energy[:w] + 1}"
      # do not process if flashed this step already
      if !@flashes[row_index.to_s + "_" + (col_index - 1).to_s]
        @rows[row_index][col_index - 1] = adjacent_energy[:w] + 1
      end
    end
  end
  if adjacent_energy[:e] < 99
    if adjacent_energy[:e] > 9
      handle_flash(adjacent_energy[:e], row_index, col_index + 1)
    else
      #puts "new energy east: #{adjacent_energy[:e] + 1}"
      # do not process if flashed this step already
      if !@flashes[row_index.to_s + "_" + (col_index + 1).to_s]
        @rows[row_index][col_index + 1] = adjacent_energy[:e] + 1
      end
    end
  end
  if adjacent_energy[:n] < 99
    if adjacent_energy[:n] > 9
      handle_flash(adjacent_energy[:n], row_index - 1, col_index)
    else
      #puts "new energy north: #{adjacent_energy[:n] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index - 1).to_s + "_" + col_index.to_s]
        @rows[row_index - 1][col_index] = adjacent_energy[:n] + 1
      end
    end
  end
  if adjacent_energy[:s] < 99
    if adjacent_energy[:s] > 9
      handle_flash(adjacent_energy[:s], row_index + 1, col_index)
    else
      #puts "new energy south: #{adjacent_energy[:s] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index + 1).to_s + "_" + col_index.to_s]
        @rows[row_index + 1][col_index] = adjacent_energy[:s] + 1
      end
    end
  end
  if adjacent_energy[:nw] < 99
    if adjacent_energy[:nw] > 9
      handle_flash(adjacent_energy[:nw], row_index - 1, col_index - 1)
    else
      #puts "new energy northwest: #{adjacent_energy[:nw] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index - 1).to_s + "_" + (col_index - 1).to_s]
        @rows[row_index - 1][col_index - 1] = adjacent_energy[:nw] + 1
      end
    end
  end
  if adjacent_energy[:ne] < 99
    if adjacent_energy[:ne] > 9
      handle_flash(adjacent_energy[:ne], row_index - 1, col_index + 1)
    else
      #puts "new energy northeast: #{adjacent_energy[:ne] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index - 1).to_s + "_" + (col_index + 1).to_s]
        @rows[row_index - 1][col_index + 1] = adjacent_energy[:ne] + 1
      end
    end
  end
  if adjacent_energy[:sw] < 99
    if adjacent_energy[:sw] > 9
      handle_flash(adjacent_energy[:sw], row_index + 1, col_index - 1)
    else
      #puts "new energy southwest: #{adjacent_energy[:sw] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index + 1).to_s + "_" + (col_index - 1).to_s]
        @rows[row_index + 1][col_index - 1] = adjacent_energy[:sw] + 1
      end
    end
  end
  if adjacent_energy[:se] < 99
    if adjacent_energy[:se] > 9
      handle_flash(adjacent_energy[:se], row_index + 1, col_index + 1)
    else
      #puts "new energy southeast: #{adjacent_energy[:se] + 1}"
      # do not process if flashed this step already
      if !@flashes[(row_index + 1).to_s + "_" + (col_index + 1).to_s]
        @rows[row_index + 1][col_index + 1] = adjacent_energy[:se] + 1
      end
    end
  end
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
  #puts "Row #0"
  #print_grid
  #process_row(@rows[0], 0)

  @rows.each_with_index do |row, index|
    puts "Row ##{index}"
    print_grid

    process_row(row, index)
  end
end

def process_steps(num_steps)
  num_steps.times do |num_step|
    puts "Step ##{num_step}"
    @flashes = {}
    process_rows
  end
end

puts "----- STARTING -----"
parse_input('test_input.txt')
#puts "#{@rows}"
#puts get_adjacent(1, 1)
#puts "Step 1"
#step(@rows[0][2], 0, 2)
#puts "Step 2"
#step(@rows[0][2], 0, 2)

process_steps(2)
puts "# of flashes: #{@numflashes}"