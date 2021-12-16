# Packet pattern:
# - 0 + First 3 = version
# - 0 + Second 3 = type id
# - Remaining (in chunks of 5) are values
# type == 4 == literal value
#  - encode a single number
#  - split into groups of 5 (1 is a previx for remaining 4, 0 is the previx of the last one)
#  - then padded zeroes so whole (version, type, remiaining) are divisible by 4?
#  - Those groups then are binary converted to decimal is the answer
# type != 4 == operator value
#  - contains one or more packet
#  - performs operation on 1 or more packets inside
#  = 0 + first 3 = version
#  - 0 + second 3 = type
#  - 1 = length type id
#  - if 0, next 15 are total lenght in bits (represented in binary)
#  - if 1, next 11 are # of sub-packets immediately contained in packet

def decode_binary_message(message)
  version = message[0..2].to_i(2)
  type = message[3..5].to_i(2)
  puts "Version: #{version}"
  puts "Type: #{type}"

  if type == 4
    return decode_literal(message[6..(message.length - 1)])
  else
  end
end

def decode_literal(message)
  binary = ""

  0.step do |i|
    chunk = message[(0 + i * 5)..(4 + i * 5)]
    binary += chunk[1..4]

    break if chunk[0] == "0"
  end

  return binary.to_i(2)
end

@transmission = File.readlines('literal_val_input.txt')[0].gsub("\n", '')
puts "#{@transmission}"
puts decode_binary_message(@transmission)
