# Array representing the # of fish in a given state modeled as
# [n_0, n_1, n_2, n_3, n_4, n_5, n_6, n_7, n_8]
@school = [0, 0, 0, 0, 0, 0, 0, 0, 0]
@initial_state = []

def parse_input(file)
  read_file = File.readlines(file)

  @initial_state = read_file[0].split(",")
end

def initialize_school(initial_state)
  initial_state.each do |fish|
    @school[fish.to_i] += 1
  end
end

def update_population(school)
  parents = school[0]

  school.shift()
  school[8] = parents
  school[6] += parents
end

def project_population(days)
  days.times do |i|
    update_population(@school)
  end
end

parse_input('test_input.txt')

initialize_school(@initial_state)
project_population(80)

puts "Total lanternfish population: #{@school.sum()}"
