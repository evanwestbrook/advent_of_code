# Key used to store default display key configurations from prompt
@display_key = {
  "0": "abcefg",
  "1": "cf",
  "2": "acdeg",
  "3": "acdfg",
  "4": "bcdf",
  "5": "abdfg",
  "6": "abdefg",
  "7": "acf",
  "8": "abcdefg",
  "9": "abcdfg"
}

@signals = []
@display_frequency = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |signal|
    signal = signal.split(" | ")
    @signals << { patterns: signal[0].split(" "), outputs: signal[1].split(" ") }

  end
end

def get_length_frequency
  # Method to determine frequency of length of each key configuration
  # Used to narrow down numbers we know automatically by length
  @display_key.each do |key, value|
    if @display_frequency[value.length]
      @display_frequency[value.length] << key.to_s
    else
      @display_frequency[value.length] = [key.to_s]
    end
  end
end

def check_length_frequency(digit_value)
  # Method to determine if a given output matches numbers we know automatically by length
  if @display_frequency[digit_value.length].length == 1
    return { original_value: digit_value, decoded_value: @display_frequency[digit_value.length][0] }
  else
    return nil
  end
end

def decode_pattern(patterns)
  found_array = [] # Array used to remove identified values from signal after all are handled

  patterns.each_with_index do |pattern, index|
    if check_length_frequency(pattern)

      if @search_vals.include? check_length_frequency(pattern)[:decoded_value]
        @search_matches += 1 # Log value if it was in our search
      end

      found_array << pattern # Add to list of identified items
    else
      # TODO: Pass to further processing
    end
  end

  patterns = patterns - found_array # Remove identified values that no longer require processing
end

def check_signals(signals)
  signals.each_with_index do |signal, index|
    #decode_output(signal)
    decode_pattern(signal[:outputs])
  end
end

puts "------ STARTING ------"

@search_vals = ["1", "4", "7", "8"]
@search_matches = 0

parse_input('test_input_2.txt')

get_length_frequency
check_signals(@signals)

#decode_output(@signals[1])

puts "# of matches: #{@search_matches}"
