# Find # of distinct paths that start at start and end at end
# Don't visit small caves more than once

@datas = []
@starts = []
@ends = []
@connections = {}

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
      @starts << data[1]
    elsif data[1] == "end"
      @ends << data[0]
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

parse_input('test_input.txt')
puts "#{@datas}"
map_connections
puts "#{@starts}"
puts "#{@ends}"
puts "#{@connections}"
