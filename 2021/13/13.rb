@dots = {}
@folds = []

def print_grid(dots)
  # Hard coded print grid logic for test input debugging
  15.times do |i|
    row_text = ""
    11.times do |j|
      if dots[j.to_s + "_" + i.to_s]
        row_text += "#"
      else
        row_text += "."
      end
    end
    puts row_text
  end
end

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each do |row|
    # Remove new line character
    row = row.gsub("\n", '')

    # Handle coordinates
    if row.include? ","
      row = row.split(",")
      # Don't need to add more than 1 dot in a coordinate
      if !@dots[row[0] + "_" + row[1]]
        @dots[row[0] + "_" + row[1]] = [row[0].to_i, row[1].to_i]
      end
    end

    # Handle fold instructions
    if row.include? "fold"
      row = row.split("=")
      @folds << { row[0].split(" ")[-1]=> row[1].to_i }
    end
  end
end

def transpose_dot(fold_key, unit, dot, transponsed_dots)
  transpose_distance = dot[1] - (dot[1] - unit) * 2

  if fold_key == "y"
    # Check add dot if it doesn't already exists
    if !transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s]
      transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s] = [dot[0].to_i, transpose_distance]
      transponsed_dots.delete(dot[0].to_s + "_" + dot[1].to_s)
    else
      transponsed_dots.delete(dot[0].to_s + "_" + dot[1].to_s)
    end
  end
end

def fold_dots(fold, dots)

  transposed_dots = dots.dup

  dots.each do |dot|
    # Handle y folds
    if fold.keys[0] == "y" && dot[1][1] > fold[fold.keys[0]]
      transpose_dot(fold.keys[0], fold[fold.keys[0]], dot[1], transposed_dots)
    elsif fold.keys[0] == "x" && dot[1][0] > fold[fold.keys[0]]
    # Handle x folds
    end
  end

  puts " TRANSPOSED GRID "
  print_grid(transposed_dots)
  return transposed_dots

end

puts "----- Starting -----"

parse_input('test_input.txt')
#puts "Starting dots: #{@dots}"
#puts "Folds: #{@folds}"
puts " STARTING GRID "
print_grid(@dots)
puts "Transposed dots: #{fold_dots(@folds[0], @dots).length}"
