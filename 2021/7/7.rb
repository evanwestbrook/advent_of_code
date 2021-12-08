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

def process_fuel_scenarios
  fuel_scenarios = {}
  (@crabs.max - @crabs.min).times do |position|
    fuel_scenarios[position] = calculate_fuel(position, @crabs)
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
    (crab - position).abs().times do |i|
      fuel_consumption += i + 1
    end
  end

  return fuel_consumption
end

parse_input('input.txt')

fuel_scenarios = process_fuel_scenarios
min_fuel = find_min_fuel(fuel_scenarios)
puts "Minimum Fuel Position: #{min_fuel[:position]}"
puts "Minimum Fuel Cost: #{min_fuel[:fuel]}"
