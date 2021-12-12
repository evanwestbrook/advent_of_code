# Find # of distinct paths that start at start and end at end
# Don't visit small caves more than once

@datas = []
@startings = []
@endings = {}
@connections = {}
@paths = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')

    # Convert row content to array
    @datas << row.split("-")
  end
end

def map_connections
  @datas.each do |data|
    if data[0] == "start"
      @startings << data[1]
    elsif data[1] == "end"
      @endings[data[0]] = data[0]
    else
      if @connections[data[0]]
        @connections[data[0]] << data[1]
      else
        @connections[data[0]] = [data[1]]
      end

      if @connections[data[1]]
        @connections[data[1]] << data[0]
      else
        @connections[data[1]] = [data[0]]
      end
    end
  end
end

def is_lower_case?(character)
  if character != character.upcase
    return true
  else
    return false
  end
end

def visit_cave(starting, connections, cave_path, small_cave_visited)

  small_cave_visited = small_cave_visited.dup

  # Visit Cave
  cave_path += ",#{starting}"
  if is_lower_case?(starting)
    small_cave_visited[starting] = 1
  end

  #Determine if we should log an ending point
  if @endings[starting]
    @paths << "#{cave_path},end"
  end

  # Find caves accessed via starting point
  next_caves = connections[starting]
  puts next_caves
  puts small_cave_visited
  puts "Cave path: #{cave_path}"



  # Vist next cave if we can
  next_caves.each do |next_cave|
    # Make sure not to re-visit small caves
    if !small_cave_visited[next_cave]
      # Log visit to cave
      visit_cave(next_cave, connections, cave_path, small_cave_visited)
    end
  end

end

parse_input('test_input.txt')
puts "#{@datas}"
map_connections
puts "#{@startings}"
puts "#{@endings}"
puts "#{@connections}"

def find_from_start(starting, connections)
  small_cave_visited = {}

  # Visit starting and log visit
  cave_path = "start"


  visit_cave(starting, connections, cave_path, small_cave_visited)
end

def find_paths
  @startings.each do |starting|
    find_from_start(starting, @connections)
  end
end

#find_paths(@startings[0], @endings[0], @connections)
#find_from_start(@startings[0], @endings[0], @connections)
find_paths
puts "#{@paths}"
