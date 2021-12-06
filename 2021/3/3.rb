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

def update_bit_frequency(byte, frequency_hash)
  byte.gsub("\n","").split('').each_with_index do |bit, index|
    if frequency_hash[index]
      frequency_hash[index] = frequency_hash[index] + bit.to_i
    else
      frequency_hash[index] = bit.to_i
    end
  end
end

def get_bit_frequency(byte_list, bit_hash)
  byte_list.each do |byte|
    update_bit_frequency(byte, bit_hash)
  end
end

def get_binary_readings(frequency_list, num_readings)
  frequency_list.each_with_index do |bit, index|
    if frequency_list[index].to_f / num_readings >= 0.5
      @gamma_binary += "1"
      @epsilon_binary += "0"
    else
      @gamma_binary += "0"
      @epsilon_binary += "1"
    end
  end
end

def get_acceptable_vals(byte_list, bit_criteria)

  bit_freq_list = {}

  byte_list.each do |byte|

  end
end

parse_file('test_input.txt')
get_bit_frequency(@array, @bit_list)
get_binary_readings(@bit_list, @array.length.to_f)
puts "Gamma binary: #{@gamma_binary}. Gamma decimal: #{@gamma_binary.to_i(2)}."
puts  "Epsilon binary: #{@epsilon_binary}. Epsilon decimal: #{@epsilon_binary.to_i(2)}"
puts "Power consumption: #{@gamma_binary.to_i(2) * @epsilon_binary.to_i(2)}"
