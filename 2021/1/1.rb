# Lessons learned from converting to all Enuemrable methods
# 1. For parsing an input file into an array, collect does a lot of work for us
#    a. Map does something similar, and I'm still not sure of the differences
# 2. Each consecutive works well for comparing items in an array similar to how a .each_with_index would work.
#    However, it is a little easier to ready, as there are fewer instances where we are juggling indices
# 3. Inject was not as useful here as a solution because we are not doing something cumulative. The solution relies
#    on items from previous aspects of the array

@array = File.readlines('input.txt').collect { |line| line.gsub("\n", '').to_i}
puts "Part 1 solution: #{@array.each_cons(2).select { |x| x[0] < x[1] }.count}"
puts "Part 2 solution: #{@array.each_cons(3).map(&:sum).each_cons(2).select { |x| x[0] < x[1] }.count}"
