@polymer_pairs = []
@insertion_rules = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    # Remove new line character
    row = row.gsub("\n", '')

    # Handle polymer template
    if index == 0
      @polymer_pairs = update_polymer_pairs(@polymer_pairs, row)
    end

    # Handle insertion rules
    if row.include? "->"
      row = row.split(" -> ")
      @insertion_rules[row[0]] = row[1]

    end
  end
end

def update_polymer_pairs(polymer_pairs, insertion)
  insertion.length.times do |i|
    if !(i == insertion.length - 1)
      polymer_pairs << insertion[i] + insertion[i + 1]
    end
  end

  return polymer_pairs
end

def step_polymer(steps)
  steps.times do |step|
  end
end

puts "----- Starting -----"
parse_input('test_input.txt')
puts @polymer_pairs
puts @insertion_rules