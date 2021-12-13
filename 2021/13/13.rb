@dots = {}
@folds = []

def print_grid(dots)
  max_x = 0
  dots.each do |key, value|
    if value[0] > max_x
      max_x = value[0]
    end
  end

  max_y = 0
  dots.each do |key, value|
    if value[1] > max_y
      max_y = value[1]
    end
  end

  (max_y + 1).times do |i|
    row_text = ""
    (max_x + 1).times do |j|
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


  if fold_key == "y"
    transpose_distance = dot[1] - (dot[1] - unit) * 2
    # Check add dot if it doesn't already exists
    if !transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s]
      transponsed_dots[dot[0].to_s + "_" + transpose_distance.to_s] = [dot[0].to_i, transpose_distance]
    end
  elsif fold_key == "x"
    transpose_distance = dot[0] - (dot[0] - unit) * 2
    # Check add dot if it doesn't already exists
    if !transponsed_dots[transpose_distance.to_s + "_" + dot[1].to_s]
      transponsed_dots[transpose_distance.to_s + "_" + dot[1].to_s] = [transpose_distance, dot[1].to_i]
    end
  end

  transponsed_dots.delete(dot[0].to_s + "_" + dot[1].to_s)
end

def fold_dots(fold, dots)
  # Deep copy so that we can update hash while iterating over it
  transposed_dots = dots.dup

  dots.each do |dot|
    # Handle y folds
    if fold.keys[0] == "y" && dot[1][1] > fold[fold.keys[0]]
      transpose_dot(fold.keys[0], fold[fold.keys[0]], dot[1], transposed_dots)
    elsif fold.keys[0] == "x" && dot[1][0] > fold[fold.keys[0]]
    # Handle x folds
      transpose_dot(fold.keys[0], fold[fold.keys[0]], dot[1], transposed_dots)
    end
  end

  return transposed_dots
end

def complete_folds(folds, dots)
  new_dots = dots.dup

  folds.each_with_index do |fold, index|
    new_dots = fold_dots(fold, new_dots)
  end

  return new_dots
end

puts "----- Starting -----"
parse_input('input.txt')

puts " STARTING GRID "
puts "Dots visible after completing first fold: #{fold_dots(@folds[0], @dots).length}"
puts " FINAL GRID"
puts print_grid(complete_folds(@folds, @dots))
