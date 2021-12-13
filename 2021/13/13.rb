@dots = {}
@folds = []

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
  puts "Fold: #{fold_key}"
  puts "Unit: #{unit}"
  puts "Dot: #{dot}"

  transpose_distance = dot[1] - (dot[1] - unit) * 2
  puts "Transpose distance: #{transpose_distance}"

  if fold_key == "y"
    # Check add dot if it doesn't already exists
    if !transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s]
      transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s] = [dot[0].to_i, transpose_distance]
      transponsed_dots.delete(dot[0].to_s + "_" + dot[1].to_s)
    end
  end

end

def fold_dots(fold, dots)

  transposed_dots = dots.dup

  dots.each do |dot|
    puts "dot #{dot}"
    puts dot[0]
    # Handle y folds
    if fold.keys[0] == "y" && dot[1][1] > fold[fold.keys[0]]
      transpose_dot(fold.keys[0], fold[fold.keys[0]], dot[1], transposed_dots)
    elsif fold.keys[0] == "x" && dot[1][0] > fold[fold.keys[0]]
    # Handle x folds
    end
  end

  puts "Transposed dots: #{@transposed_dots}"
end

parse_input('test_input.txt')
puts "#{@dots}"
puts "#{@folds}"
fold_dots(@folds[0], @dots)
puts "#{@dots}"