# use hash of legitimate pairs form insertion rules
# Create a hash of pairs from polymer
# Each step evaluate hash of pairs against insertion rules
#   If insertion rules are not in hash pair, add two (NN ->> NC, CN)
#   If insertion rules are there, index by 1
# For scoring, still evaluate keys against element freqency. This way, we're still evaluting the string

@insertion_rules = {}
@polymer = ""
@element_frequency = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    # Remove new line character
    row = row.gsub("\n", '')

    # Handle polymer template
    if index == 0
      @polymer = row

      # Initialize potential elements in polymer
      row.length.times do |i|
        update_possible_elements(row[i])
      end
    end

    # Handle insertion rules
    if row.include? "->"
      row = row.split(" -> ")
      @insertion_rules[row[0]] = row[1]

      # Initialize potential elements in polymer
      update_possible_elements(row[1])
    end
  end
end

def update_possible_elements(element)
  if !@element_frequency[element]
    @element_frequency[element] = 0
  end
end

def update_polymer(polymer)
  updated_polymer = ""
  polymer.length.times do |element|
    if !(element == polymer.length - 1)
      updated_polymer += polymer[element]
      updated_polymer += @insertion_rules[polymer[element] + polymer[element + 1]]
    else
      updated_polymer += polymer[element]
    end
  end

  return updated_polymer
end

def step_polymer(steps)
  steps.times do |step|
    @polymer = update_polymer(@polymer)
  end
end

def get_element_frequency(polymer, element_frequency)
  element_frequency.each do |key, value|
    element_frequency[key] = polymer.count(key.to_s)
  end

  return element_frequency
end

def get_polymer_score(polymer)
  element_frequency = get_element_frequency(polymer, @element_frequency)

  return element_frequency.values.max - element_frequency.values.min
end

puts "----- Starting -----"
parse_input('test_input.txt')
step_polymer(10)

puts "The solution to part 2 is: #{get_polymer_score(@polymer)}"
