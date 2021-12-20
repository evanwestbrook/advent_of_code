@array = File.readlines('input.txt').collect { |line| line.gsub("\n", '').to_i}
puts "Part 1 solution: #{@array.each_cons(2).select { |x| x[0] < x[1] }.count}"
puts "Part 2 solution: #{@array.each_cons(3).map(&:sum).each_cons(2).select { |x| x[0] < x[1] }.count}"
