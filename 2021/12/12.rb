@datas = []
@startings = {}
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
      @startings[data[1]] = data[1]
    elsif data[1] == "start"
      @startings[data[0]] = data[0]
    elsif data[1] == "end"
      @endings[data[0]] = data[0]
    elsif data[0] == "end"
      @endings[data[1]] = data[1]
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

def visit_cave(starting, connections, cave_path, small_caves_visited)
  # Duplicate running list of visted small caves so we can evaluate in each cave context
  small_caves_visited = small_caves_visited.dup

  # Log visit to cave and increment for small cave visits
  cave_path += ",#{starting}"
  if is_lower_case?(starting)
    if small_caves_visited[starting]
      small_caves_visited[starting] += 1
    else
      small_caves_visited[starting] = 1
    end
  end

  # Determine if we should log an ending point
  if @endings[starting]
    @paths << "#{cave_path},end"
  end

  # Find caves accessed via starting point and vist next cave if we can
  connections[starting].each do |next_cave|
    # Revisit small cave if none have been visited twice
    if (small_caves_visited.select { |key, value| value > 1}).length == 0
      visit_cave(next_cave, connections, cave_path, small_caves_visited)
    # Make sure not to re-visit small caves
    elsif !small_caves_visited[next_cave]
      visit_cave(next_cave, connections, cave_path, small_caves_visited)
    end
  end
end

def find_from_start(starting, connections)
  small_caves_visited = {}

  # Visit starting cave and start exploring
  cave_path = "start"
  visit_cave(starting, connections, cave_path, small_caves_visited)
end

def find_paths
  @startings.each do |key, starting|
    find_from_start(starting, @connections)
  end
end

puts "----- STARTING -----"
parse_input('input.txt')
map_connections
find_paths
puts "Total # of paths: #{@paths.length}"
