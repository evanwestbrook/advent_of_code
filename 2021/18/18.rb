@snailfish_numbers = []

def parse_input(file)
  File.readlines(file).each do |row|
    snailfish_number = row.gsub("\n", '')
    #snailfish_number = eval(snailfish_number)
    @snailfish_numbers << snailfish_number
  end
end

def parse_snailfish_number(snailfish_number)
  # Parse number into ruby complex number of a+bi where a is number and b is depth
  depth = 0
  parsed_number = []

  snailfish_number.chars.each do |char|
    if char.match?(/\d/)
      parsed_number << char.to_i + depth.i
    elsif char == "["
      depth += 1
    elsif char == "]"
      depth -= 1
    end
  end

  return parsed_number
end

def add(left, right)
  return [left, right]
end

def split(sf_num, index)
  sf_num.insert(index + 1, sf_num[index].real / 2.0).round + (sf_num[index].imaginary + 1).i)
  sf_num[index] = sf_num[index].real / 2 + (sf_num[index].imaginary + 1).i
end

def explode(exploder, snailfish_number)
end

parse_input('test_input_6.txt')

puts "#{@snailfish_numbers}"
puts "#{parse_snailfish_number(@snailfish_numbers[4])}"

