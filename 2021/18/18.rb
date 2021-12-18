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

parse_input('test_input_6.txt')
#puts "#{@snailfish_numbers}"

puts "#{add(eval("[1,2]"), eval("[[3,4],5]"))}"

