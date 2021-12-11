require './cardinal_directions.rb'

@rows = []
@numflashes = 0
@flashes = {}

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

def print_grid
  # Prints grid to console for easier debugging
  @rows.each do |row|
    row_string = ""
    row.each do |col|
      row_string += col.to_s
    end
    puts row_string
  end
end

def step(energy, row_index, col_index)
  if !@flashes[row_index.to_s + "_" + col_index.to_s]
    energy += 1
    @rows[row_index][col_index] = energy
  end

  if @rows[row_index][col_index] > 9
    handle_flash(@rows[row_index][col_index], row_index, col_index)
  end
end

def handle_flash(energy, row_index, col_index)
  # Add coordinates to the flashes already handled by this flash
  @flashes[row_index.to_s + "_" + col_index.to_s] = energy
  # Reset energy levels for next step
  @rows[row_index][col_index] = 0

  # Recursively process flash
  @numflashes += 1
  flash(row_index, col_index)
end

def process_adjacent(adjacent_energy, row_index, col_index)
  # Processes potential flashes for octopuses adjacent to a flash
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
  # Process flashes for each adjacent octopus
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
    step(col, row_index, index)
  end
end

def process_rows
  @rows.each_with_index do |row, index|
    process_row(row, index)
  end
end

def process_steps(num_steps)
  num_steps.times do |num_step|
    @flashes = {}
    process_rows
  end
end

puts "----- STARTING -----"
parse_input('input.txt')

process_steps(100)
puts "# of flashes: #{@numflashes}"
