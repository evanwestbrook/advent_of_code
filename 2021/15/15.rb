# Examine all paths. There's no minimization logic, but we're removing some paths due to dead ends
# for each path don't revisit a point
# if no valid points remain on a path, it's a dead end and stop recursion

require './cardinal_directions.rb'
@rows = []


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
  if !left_boundary?(curr_coord[1])
    puts "go left"
  end
  if !right_boundary?(@rows, curr_coord[0], curr_coord[1])
    puts "go right"
  end
  if !top_boundary?(curr_coord[0])
    puts "go top"
  end
  if !bottom_boundary?(@rows, curr_coord[0])
    puts "go bottom"
  end
end

puts "===== STARTING ====="
parse_input('test_input.txt')
#puts "#{@rows}"
find_paths([1,1])
