@num_increases = 0

def file_to_array(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    @array << line.to_i
  end
end

def get_increases
  @array.each_with_index do |element, index|
    if index > 0
      if element > @array[index - 1]
        @num_increases += 1
      end
    end
  end
end

file_to_array('input.txt')
get_increases
puts @num_increases
