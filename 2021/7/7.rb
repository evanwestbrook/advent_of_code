@crabs = []

def parse_input(file)
  read_file = File.readlines(file)

  read_file[0].split(",").each do |i|
    @crabs << i.to_i
  end
end

def calculate_fuel(position, crabs)
  fuel_consumption = 0
  crabs.each do |crab|
    fuel_consumption += (crab - position).abs()
  end

  return fuel_consumption
end

# parse crab coordinates into freqency table and then find the most commons?
# But if there was a really big one, then it could make sense for all the smalelr ones to move?

parse_input('test_input.txt')
puts "#{@crabs}"
puts calculate_fuel(2, @crabs)
