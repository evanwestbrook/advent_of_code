# gamma rate is most common bit
# epsilon rate is least commit bit. Can just be the reverse of gamma

@bit_list = {}
@gamma_binary = ""
@epsilon_binary = ""

def parse_file(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    @array << line
  end
end

def split_byte (byte)
  byte.gsub("\n","").split('').each_with_index do |bit, index|
    if @bit_list[index]
      @bit_list[index] = @bit_list[index] + bit.to_i
    else
      @bit_list[index] = bit.to_i
    end
  end
end

def get_file_stats
  @array.each do |byte|
    split_byte (byte)
  end
end

def get_binary_readings
  @bit_list.each_with_index do |bit, index|
    puts "Bit: #{bit}. Index: #{index}"
  end
end

parse_file('test_input.txt')
get_file_stats
#puts @bit_list
get_binary_readings
#puts @array.length
