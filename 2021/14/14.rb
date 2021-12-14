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
  # Part 1 solution considerations:
  # 1. Is there a way to update the polymer without rebuilding it each time (i.e. insert instead of rebuild). Using
  #      an each loop prevents us from doing that natively now
end

def step_polymer(steps)
  steps.times do |step|
    @polymer = update_polymer(@polymer)
  end
end

def get_element_frequency(polymer)
  element_frequency = {}

  polymer.each do |element|
    if element_frequency[element]
      element_frequency[element] += 1
    else
      element_frequency[element] = 1
    end
  end

  return element_frequency
end

def get_polymer_score(polymer)
  element_frequency = get_element_frequency(polymer)

  return element_frequency.values.max - element_frequency.values.min
end

puts "----- Starting -----"
parse_input('input.txt')
step_polymer(10)

puts "The solution to part 1 is: #{get_polymer_score(@polymer)}"
