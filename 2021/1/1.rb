@num_increases = 0
@sum_array = []

def make_sum (index)
  sum = @array[index] + @array[index + 1] + @array[index + 2]
end

def get_increases
  @array.each_with_index do |element, index|
    if index < @array.count - 2
      @sum_array << make_sum(index)
      if index > 0
        if @sum_array[index] > @sum_array[index - 1]
          @num_increases += 1
        end
      end
    end
  end
end

@array = File.readlines('input.txt').collect { |line| line.gsub("\n", '').to_i}
#puts "#{@array}"

#file_to_array_2('small_input.txt')
#file_to_array('test_input.txt')
get_increases
puts @num_increases
