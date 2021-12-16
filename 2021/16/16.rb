# Note: Had to get help based on this solution: https://github.com/erikw/advent-of-code-solutions/blob/main/2021/day16/part1.rb
# It was approaching things in a similar way to how I did initially, but it seemed to work.
# I was having issues with my parsed array returning nested in such a manner that I couldn't parse it on subsequent
# recursions. I was having a tough time figuring it out, so I went and got help.
# This solution method works a little easier because it keeps consuming the values instead of trying to keep track of where they are.
# Ultimately, live tracking all of the items and then summing them (my initial solution) proved to be a little too
# complicated to keep track of. 

def parse_decoder(file_name)
  hex_decoder = {}

  File.readlines('hex_decoder.txt').each do |line|
    line = line.gsub("\n", '').split(" = ")
    hex_decoder[line[0]] = line[1]
  end

  return hex_decoder
end

def decode_hex(hex)
  binary = ""
  hex.length.times do |i|
    binary += @hex_decoder[hex[i]]
  end

  return binary
end

def consume_digits(digitstring, length)
  digitstring.slice!(0, length)
end

def decode_operator_l(digits, numbits)
  start_length = digits.length
  versions = 0

  while start_length - digits.length < numbits
    version = decode_transmission(digits)
    break if version.nil?

    versions += version
  end

  return versions
end

def decode_operator_n(digits, nopacks)
  packs = 0
  versions = 0
  while packs < nopacks

    v = decode_transmission(digits)
    break if v.nil?

    versions += v
    packs += 1
  end
  versions
end

def decode_literal(digits)
  binary = ""

  loop do
    chunk = consume_digits(digits, 5)
    binary += chunk[1, 4]
    break if chunk[0] == '0' || digits.length < 5
  end
  binary.to_i(2)
end

def decode_transmission(digits)
  return nil if digits.length < 11

  versions = consume_digits(digits, 3).to_i(2)
  type_id = consume_digits(digits, 3).to_i(2)
  case type_id
  when 4
    literal_value = decode_literal(digits)
  else
    length_type_id = consume_digits(digits, 1).to_i(2)
    if length_type_id == 0
      length = consume_digits(digits, 15).to_i(2)
      versions += decode_operator_l(digits, length)
    else
      length = consume_digits(digits, 11).to_i(2)
      versions += decode_operator_n(digits, length)
    end
  end
  versions
end

puts "===== STARTING ====="
@hex_decoder = parse_decoder('hex_decoder.txt')
transmission = decode_hex(File.readlines('input.txt')[0].gsub("\n", ''))

puts "Sum of Versions: #{decode_transmission(transmission)}"
