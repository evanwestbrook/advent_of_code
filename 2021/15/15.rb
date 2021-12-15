# This solution was developed based on this working solution
# https://github.com/daniero/code-challenges/commit/953f1bad1f6718d8c7d594d21f72511a98c68061#diff-78956375e2e864ca93a62928dc747f7117796e65c4dd4ce04502d61eb4cae63d
# Ultimataly, I couldn't quite get Dijkstra's algorithm figured out. I roughly understand how this code is working
# but I'm not 100% sure on the why.

require 'pqueue'
require 'set'

@rows = []
@ending_coord = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')
    cols = []

    row.length.times do |col|
      cols << row[col].to_i
    end

    @rows << cols
  end

  @ending_coord = find_stopping_coordinates(@rows)
end

def find_stopping_coordinates(rows)
  return [rows[0].length - 1, rows.length - 1]
end

def find_neighbors(grid, x, y)
  [
    [x, y - 1],
    [x + 1, y],
    [x, y + 1],
    [x - 1, y]
  ].select { |row, col|
    row >= 0 &&
    row < grid.size &&
    col >= 0 &&
    col < grid[0].size
  }
end

def find_path

  queue = PQueue.new([[0,0]]) { |a,b| a.last < b.last }
  visited = Set[]

  until queue.empty?
    position, risk = queue.pop

    # Only proceed if a given point has not already been visited
    next unless visited.add?(position)

    if position == @ending_coord
      return risk
      break
    end

    find_neighbors(@rows, position[0], position[1]).each { |x,y|
      queue.push([[x,y], risk + @rows[y][x]])
    }
  end
end

puts "===== STARTING ====="
parse_input('input.txt')

puts "The total risk of the lowest total risk path is: #{find_path}"
