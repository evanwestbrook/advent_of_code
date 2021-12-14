@polymer = []
@insertion_rules = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    # Remove new line character
    row = row.gsub("\n", '')

    # Handle polymer template
    if index == 0
      row.length.times do |i|
        if row[i]
          @polymer << row[i]
        end
      end
    end

    # Handle insertion rules
    if row.include? "->"
      row = row.split(" -> ")
      @insertion_rules[row[0]] = row[1]
    end
  end
end

def update_polymer(polymer)
  updated_polymer = []
  polymer.each_with_index do |element, index|
    if !(index == polymer.length - 1)
      updated_polymer << element
      updated_polymer << @insertion_rules[element + polymer[index + 1]]
    else
      updated_polymer << element
    end
  end

  return updated_polymer
end

def step_polymer(steps)
  steps.times do |step|
    @polymer = update_polymer(@polymer)
  end
end

puts "----- Starting -----"
parse_input('test_input.txt')
puts "#{@polymer}"
puts @insertion_rules
step_polymer(10)
puts "#{@polymer.length}"