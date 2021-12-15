# Examine all paths. There's no minimization logic, but we're removing some paths due to dead ends
# for each path don't revisit a point
# if no valid points remain on a path, it's a dead end and stop recursion

require './cardinal_directions.rb'
@rows = []
@ending_coord = []
@valid_paths = []


def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')
    cols = []

    row.length.times do |col|
      cols << row[col]
    end

    @rows << cols
  end

  @ending_coord = find_stopping_coordinates(@rows)
end

def find_stopping_coordinates(rows)
  return [rows[0].length - 1, rows.length - 1]
end

def find_paths(start_coord)
  my_path = {}
  my_path[start_coord[0].to_s + "_" + start_coord[1].to_s] = 0
  puts my_path
  move(start_coord, my_path)
end

def move(curr_coord, my_path)
  if curr_coord[0] == @ending_coord[0] && curr_coord[1] == @ending_coord[1]
    puts "valid path!"
    @valid_paths << my_path
  else
    if !left_boundary?(curr_coord[1])# && !my_path[curr_coord[0].to_s + "_" + (curr_coord[1] - 1).to_s]
      #puts "go left"
      step([curr_coord[0], curr_coord[1] - 1], my_path)
    end
    if !right_boundary?(@rows, curr_coord[0], curr_coord[1])# && !my_path[curr_coord[0].to_s + "_" + (curr_coord[1] + 1).to_s]
      #puts "go right"
      step([curr_coord[0], curr_coord[1] + 1], my_path)
    end
    if !top_boundary?(curr_coord[0])# && !my_path[(curr_coord[0] - 1).to_s + "_" + curr_coord[1].to_s]
      #puts "go top"
      step([curr_coord[0] - 1, curr_coord[1]], my_path)
    end
    if !bottom_boundary?(@rows, curr_coord[0])# && !my_path[(curr_coord[0] + 1).to_s + "_" + curr_coord[1].to_s]
      #puts "go bottom"
      step([curr_coord[0] + 1, curr_coord[1]], my_path)
    end
  end
end

def step(curr_coord, my_path)

  if my_path[curr_coord[0].to_s + "_" + curr_coord[1].to_s]
    puts "dead end"
  else
    this_path = my_path.dup
    this_path[curr_coord[0].to_s + "_" + curr_coord[1].to_s] = @rows[curr_coord[0]][curr_coord[1]]
    #puts this_path
    move(curr_coord, this_path)
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
#puts "#{@rows}"
#puts "#{@ending_coord}"
find_paths([0,0])
puts "#{@valid_paths}"
