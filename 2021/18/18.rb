@snailfish_numbers = []

def parse_input(file)
  File.readlines(file).each do |row|
    snailfish_number = row.gsub("\n", '')
    snailfish_number = eval(snailfish_number)
    @snailfish_numbers << snailfish_number
  end
end

def add(left, right)
  return [left, right]
end

def split(regular_number)
  return [(regular_number.to_f / 2).floor.to_i, (regular_number.to_f / 2).ceil.to_i]
end

def explode(exploder, snailfish_number)
end

parse_input('test_input_6.txt')

test_num = eval("[[[[[9,8],1],2],3],4]")
test_exploder = eval("[9,8]")
#puts "#{test_num[0][0][0][0]}"

#explode(test_exploder, test_num)

puts "#{split(11)}"

