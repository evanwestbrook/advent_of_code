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

def get_bit_frequency(byte_list)
  bit_hash = {}
  byte_list.each do |byte|
    update_bit_frequency(byte, bit_hash)
  end

  return bit_hash
end

def get_binary_readings(frequency_list, num_readings, bit_criteria)
  result_binary = ""
  frequency_list.each_with_index do |bit, index|
    result_binary += get_bit_value(frequency_list[index].to_f, num_readings, bit_criteria)
  end

  return result_binary
end

def get_bit_value(bit_frequency, num_readings, bit_criteria)
  result_bit = ""
  if bit_frequency / num_readings > 0.5
    if bit_criteria == 1
      result_bit = "1"
    else
      result_bit = "0"
    end
  elsif bit_frequency / num_readings == 0.5
    result_bit += bit_criteria.to_s
  else
    if bit_criteria == 1
      result_bit = "0"
    else
      result_bit = "1"
    end
  end

  return result_bit
end

def truncate_vals_list(starting_list, match_val, index)
  ending_list = []
  starting_list.each do |item|
    if item[index] == match_val
      ending_list << item
    end
  end
  return ending_list
end

def get_acceptable_vals(byte_list, bit_criteria)
  truncated_list = byte_list

  byte_list[0].split('').each_with_index do |byte, bit_index|

    bit_frequency_list = get_bit_frequency(truncated_list)

    most_common_bit_value = get_bit_value(bit_frequency_list[bit_index].to_f, truncated_list.length.to_f, bit_criteria)

    truncated_list = truncate_vals_list(truncated_list, most_common_bit_value, bit_index)

    if truncated_list.length == 1
      return truncated_list[0].gsub("\n","")
    end

  end
end

parse_file('input.txt')
puts "----------- STARTING SUBMARINE READINGS -----------"
@power_bit_frequency = get_bit_frequency(@array)
@gamma_binary = get_binary_readings(@power_bit_frequency, @array.length.to_f, 1)
@epsilon_binary = get_binary_readings(@power_bit_frequency, @array.length.to_f, 0)

puts "Gamma binary: #{@gamma_binary}. Gamma decimal: #{@gamma_binary.to_i(2)}."
puts  "Epsilon binary: #{@epsilon_binary}. Epsilon decimal: #{@epsilon_binary.to_i(2)}"
puts "Power consumption: #{@gamma_binary.to_i(2) * @epsilon_binary.to_i(2)}"

@oxygen_binary = get_acceptable_vals(@array, 1)
@c02_binary = get_acceptable_vals(@array, 0)

puts "Oxygen binary: #{@oxygen_binary}. Oxygen decimal: #{@oxygen_binary.to_i(2)}."
puts "C02 binary: #{@c02_binary}. Oxygen decimal: #{@c02_binary.to_i(2)}."
puts "Life support rating: #{@oxygen_binary.to_i(2) * @c02_binary.to_i(2)}"
