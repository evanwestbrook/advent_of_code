@crabs = []
@crab_frequencies = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file[0].split(",").each do |i|
    @crabs << i.to_i
  end
end

def get_crab_frequency(crabs)
  crabs.each do |crab|
    if @crab_frequencies[crab]
      @crab_frequencies[crab] += 1
    else
      @crab_frequencies[crab] = 1
    end
  end
end

# This solution assumes it will be optimal if at least one group of crabs does not move.
# It does not consider scenarios where some crabs are very far away and all crabs moving
# could be more efficient.
def process_fuel_scenarios
  fuel_scenarios = {}
  @crab_frequencies.each do |key, value|
    fuel_scenarios[key] = calculate_fuel(key, @crabs)
  end

  return fuel_scenarios
end

def find_min_fuel(fuel_scenarios)
  fuel_scenarios = fuel_scenarios.sort_by { |key, value| value }
  return { fuel: fuel_scenarios[0][1], position: fuel_scenarios[0][0]}
end

def calculate_fuel(position, crabs)
  fuel_consumption = 0
  crabs.each do |crab|
    fuel_consumption += (crab - position).abs()
  end

  return fuel_consumption
end

parse_input('input.txt')

get_crab_frequency(@crabs)
fuel_scenarios = process_fuel_scenarios
min_fuel = find_min_fuel(fuel_scenarios)
puts "Minimum Fuel Position: #{min_fuel[:position]}"
puts "Minimum Fuel Cost: #{min_fuel[:fuel]}"
