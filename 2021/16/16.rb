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

def decode_transmission(message)
  packet = { version: message[0..2].to_i(2), type: message[3..5].to_i(2)}

  if packet[:type] == 4
    packet[:message] = decode_literal(message[6..(message.length - 1)])
    return packet
    #return decode_literal(message[6..(message.length - 1)])
  else
    mode = message[6]
    if mode == "0"
      decode_operator_l(message[7..(message.length - 1)])
    else
      decode_operator_n(message[7..(message.length - 1)])
    end
  end
end

def decode_operator_l(message)
  length = message[0..14].to_i(2)
  to_decode = message[15..(14 + length)]
  length_traversed = 0
  packets = []

  0.step do |i|
    decoded_packet = decode_transmission(to_decode[length_traversed..to_decode.length])
    length_traversed += decoded_packet[:message][:packet_len]
    packets << decoded_packet
    if length_traversed >= length
      break
    end
  end

  return packets
end

def decode_operator_n(message)
  num_packets = message[0..10].to_i(2)
  to_decode = message[11..(message.length - 1)]
  length_traversed = 0
  packets = []

  (num_packets).times do |i|
    decoded_packet = decode_transmission(to_decode[length_traversed..to_decode.length])
    length_traversed += decoded_packet[:message][:packet_len]

    packets << decoded_packet
  end

  return packets
end


def decode_literal(message)
  binary = ""

  0.step do |i|
    chunk = message[(0 + i * 5)..(4 + i * 5)]
    binary += chunk[1..4]

    if chunk[0] == "0"
      return { binary: binary, packet_len: 6 + 5 + (i * 5)}
    end
  end
end

#@transmission = File.readlines('literal_val_input.txt')[0].gsub("\n", '')
@transmission = File.readlines('operator_val_input_2.txt')[0].gsub("\n", '')
puts "#{@transmission}"
#puts decode_transmission(@transmission)[:binary].to_i(2)
puts "#{decode_transmission(@transmission)}"