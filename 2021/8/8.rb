# Part 2 done with help of this solution:
# https://www.reddit.com/r/adventofcode/comments/rbj87a/comment/hnrs3ax/?utm_source=share&utm_medium=web2x&context=3
# Essentially, we deduce what we know about each digit and work backwards hard coding
# Things learned:
# 1. Order of inputs doesn't matter, so splitting into arrays instead of bulk strings makes processing easier down the line
# 2. Learned how to better use map
# 3. Instead of using code to process inputs through process of elimination, use what we can deduce about the number behaviors
#    and hardcode that
# 4. find is a much better search method than loops and such

@signals = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |signal|
    signal = signal.split(" | ")
    @signals << { patterns: signal[0].split(" ").map {|c| c.chars.sort}, outputs: signal[1].split(" ").map {|c| c.chars.sort} }
  end
end

def get_decoder_ring(signal)
  decoder_ring = {}
  decoder_ring[1] = signal.find { |pattern| pattern.size == 2 }
  decoder_ring[4] = signal.find { |pattern| pattern.size == 4 }
  decoder_ring[7] = signal.find { |pattern| pattern.size == 3 }
  decoder_ring[8] = signal.find { |pattern| pattern.size == 7 }
  decoder_ring[6] = signal.find { |pattern| pattern.size == 6 && (pattern - decoder_ring[1]).size == 5 }
  decoder_ring[9] = signal.find { |pattern| pattern.size == 6 && (pattern - decoder_ring[4]).size == 2 }
  decoder_ring[0] = signal.find { |pattern| pattern.size == 6 && pattern != decoder_ring[6] && pattern != decoder_ring[9] }
  decoder_ring[3] = signal.find { |pattern| pattern.size == 5 && (pattern - decoder_ring[1]).size == 3 }
  decoder_ring[2] = signal.find { |pattern| pattern.size == 5 && (pattern - decoder_ring[9]).size == 1 }
  decoder_ring[5] = signal.find { |pattern| pattern.size == 5 && pattern != decoder_ring[2] && pattern != decoder_ring[3] }

  return decoder_ring
end

def decode_signal(signal)
  decoder_ring = get_decoder_ring(signal[:patterns])
  output_value = ""

  signal[:outputs].each do |value|
    output_value += decoder_ring.key(value).to_s
  end

  @final_sum += output_value.to_i
end

def check_signals(signals)
  signals.each do |signal|
    decode_signal(signal)
  end
end

puts "------ STARTING ------"
@final_sum = 0

parse_input('input.txt')

check_signals(@signals)
puts "Final sum is: #{@final_sum}"
