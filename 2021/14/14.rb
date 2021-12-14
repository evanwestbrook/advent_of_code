# use hash of legitimate pairs form insertion rules
# Create a hash of pairs from polymer
# Each step evaluate hash of pairs against insertion rules
#   If insertion rules are not in hash pair, add two (NN ->> NC, CN)
#   If insertion rules are there, index by 1
# For scoring, still evaluate keys against element freqency. This way, we're still evaluting the string

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
          @polymer_pairs[row[i] + row[i + 1]] = increment_polymer_pair(row[i] + row[i + 1], @polymer_pairs)
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

def increment_polymer_pair(element, polymer_pairs)
  if !polymer_pairs[element]
    return 1
  else
    return polymer_pairs[element] += 1
  end
end

def update_polymer_pairs(element, polymer_pairs)

  if !polymer_pairs[element]
    polymer_pairs[element] = 1
  else
    polymer_pairs[element] += 1
  end

  return polymer_pairs
end

def update_possible_elements(element)
  if !@element_frequency[element]
    @element_frequency[element] = 0
  end
end

def update_polymer(polymer_pairs)
  updated_polymer_pairs = {}

  polymer_pairs.each do |polymer_pair|
    polymer_pair[1].times do |i|
      puts "UPdated pairs at this instance: #{updated_polymer_pairs}"
      puts "Polymer pair: #{polymer_pair}"
      new_polymers = [polymer_pair[0][0] + @insertion_rules[polymer_pair[0]], @insertion_rules[polymer_pair[0]] + polymer_pair[0][1]]

      puts "becomes: #{new_polymers}"
      new_polymers.each do |new_polymer|
        puts "For #{new_polymer}"
        puts "current value: #{updated_polymer_pairs[new_polymer]}"

        updated_polymer_pairs[new_polymer] = increment_polymer_pair(new_polymer, updated_polymer_pairs)
        puts "new value: #{updated_polymer_pairs[new_polymer]}"
        #updated_polymer_pairs = update_polymer_pairs(new_polymer, polymer_pairs)
      end
    end
  end

  #puts updated_polymer_pairs

  return updated_polymer_pairs
end

def step_polymer(steps)
  steps.times do |step|
    puts "---- STEP #{step} -----"
    @polymer_pairs = update_polymer(@polymer_pairs)
    puts "Pairs after step: #{@polymer_pairs}"
  end
end

def get_element_frequency(polymer_pairs, element_frequency)




  #element_frequency.each do |key, value|
  #  element_frequency[key] = polymer.count(key.to_s)
  #end

  return element_frequency
end

def get_polymer_score(polymer)
  element_frequency = get_element_frequency(polymer, @element_frequency)

  return element_frequency.values.max - element_frequency.values.min
end

puts "----- Starting -----"
parse_input('test_input.txt')
puts @polymer_pairs
#puts @element_frequency
#insert_polymer("NN")
step_polymer(3)
puts @polymer_pairs

#puts "The solution to part 2 is: #{get_polymer_score(@polymer)}"
