# Note: Had to get help based on this solution: https://github.com/erikw/advent-of-code-solutions/blob/main/2021/day16/part2.rb
# Ultimately, it was frustratings, as the original way I was doing things (storing in the array) for processing
# later is how this solution was approached.
# In the future, I think the lesson learned was that I was approaching it the correct way, but I was approaching it
# in a more complicated manner. Instead of keeping the entire string, I could keep consuming it. There were also
# better ways that I could iterate over the messages while processing.

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
  values = []

  while start_length - digits.length < numbits
    value = decode_transmission(digits)
    break if value.nil?

    values << value
  end

  return values
end

def decode_operator_n(digits, nopacks)
  packs = 0
  values = []
  while packs < nopacks

    value = decode_transmission(digits)
    break if value.nil?

    values << value
    packs += 1
  end

  return values
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

def decode_subpacks(digits)
  length_type_id = consume_digits(digits, 1).to_i(2)

  if length_type_id == 0
    length = consume_digits(digits, 15).to_i(2)
    decode_operator_l(digits, length)
  else
    length = consume_digits(digits, 11).to_i(2)
    decode_operator_n(digits, length)
  end
end

def decode_transmission(digits)
  return nil if digits.length < 11

  version = consume_digits(digits, 3).to_i(2)
  type_id = consume_digits(digits, 3).to_i(2)
  case type_id
  when 0
    decode_subpacks(digits).sum
  when 1
    decode_subpacks(digits).inject(&:*)
  when 2
    decode_subpacks(digits).min
  when 3
    decode_subpacks(digits).max
  when 4
    literal_value = decode_literal(digits)
  when 5
    decode_subpacks(digits).each_cons(2).all? { |a, b| a > b } ? 1 : 0
  when 6
    decode_subpacks(digits).each_cons(2).all? { |a, b| a < b } ? 1 : 0
  when 7
    decode_subpacks(digits).each_cons(2).all? { |a, b| a == b } ? 1 : 0
  end
end

puts "===== STARTING ====="
@hex_decoder = parse_decoder('hex_decoder.txt')
transmission = decode_hex(File.readlines('input.txt')[0].gsub("\n", ''))

puts "Values: #{decode_transmission(transmission)}"
