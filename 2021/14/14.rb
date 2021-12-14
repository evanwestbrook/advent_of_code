@insertion_rules = {}
@polymer_pairs = {}
@element_frequency = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |row, index|
    # Remove new line character
    row = row.gsub("\n", '')

    # Handle polymer template
    if index == 0

      row.length.times do |i|
        # Initialize potential elements used
        update_possible_elements(row[i])
        # Initialize element pairs in polymer
        if !(i == row.length - 1)
          @polymer_pairs[row[i] + row[i + 1]] = increment_polymer_pair(row[i] + row[i + 1], @polymer_pairs, 1)
        end
      end
    end

    # Handle insertion rules
    if row.include? "->"
      row = row.split(" -> ")
      @insertion_rules[row[0]] = row[1]

      # Initialize potential elements used
      update_possible_elements(row[1])
    end
  end
end

def increment_polymer_pair(element, polymer_pairs, multiplier)
  # Apply multiplier here based on frequency to prevent exponentially evaluating solution
  if !polymer_pairs[element]
    return 1  * multiplier
  else
    return polymer_pairs[element] += (1 * multiplier)
  end
end

def update_possible_elements(element)
  if !@element_frequency[element]
    @element_frequency[element] = 0
  end
end

def update_polymer(polymer_pairs)
  updated_polymer_pairs = {}

  polymer_pairs.each do |polymer_pair|
    new_polymers = [polymer_pair[0][0] + @insertion_rules[polymer_pair[0]], @insertion_rules[polymer_pair[0]] + polymer_pair[0][1]]

    new_polymers.each do |new_polymer|
      updated_polymer_pairs[new_polymer] = increment_polymer_pair(new_polymer, updated_polymer_pairs, polymer_pair[1])
    end
  end

  return updated_polymer_pairs
end

def step_polymer(steps)
  steps.times do |step|
    @polymer_pairs = update_polymer(@polymer_pairs)
  end
end

def get_element_frequency(polymer_pairs, element_frequency)

  freq_0 = element_frequency.dup
  freq_1 = element_frequency.dup

  # Determine frequency of each pair
  polymer_pairs.each do |key, value|
    freq_0[key[0]] += value
    freq_1[key[1]] += value
  end

  # Score based on the max frequenecy of each pair
  element_frequency.each do |key, value|
    element_frequency[key] = [freq_0[key], freq_1[key]].max
  end

  return element_frequency
end

def get_polymer_score(polymer)
  element_frequency = get_element_frequency(polymer, @element_frequency)

  return element_frequency.values.max - element_frequency.values.min
end

def sum_polymer_pairs(polymer_pairs)
  mysum = 0
  polymer_pairs.each do |key, value|
    mysum += value
  end

  return mysum
end

puts "----- Starting -----"
parse_input('input.txt')
step_polymer(40)

puts "The solution to part 2 is: #{get_polymer_score(@polymer_pairs)}"
