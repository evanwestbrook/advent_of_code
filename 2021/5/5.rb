@vent_lines = []
@vent_occupation = {}

def parse_input(file)
  read_file = File.readlines(file)

  read_file.each_with_index do |line, index|
    parsed_line = line.gsub(/ -> /, ",").split(",")
    vent_line = []
    parsed_line.each do |coordinate|
      vent_line << coordinate.to_i
    end

    @vent_lines << vent_line
  end
end

def is_horizontal?(line_coordinates)
  if line_coordinates[1] == line_coordinates[3]
    return true
  end
    return false
end

def is_diagonal?(line_coordinates)
  if line_coordinates[1] != line_coordinates[3] && line_coordinates[0] != line_coordinates[2]
    true
  else
    false
  end
end

def update_coord_occupation(coord)
  if @vent_occupation[coord]
    @vent_occupation[coord] += 1
  else
    @vent_occupation[coord] = 1
  end
end

def update_occupation(coord_1, coord_2, coord_primary, direction)
  start_coord = [coord_1, coord_2].min
  end_coord = [coord_1, coord_2].max

  (end_coord - start_coord + 1).times do |i|
    coord = ""
    if direction == "h"
      coord = (start_coord + i).to_s + "_" + coord_primary.to_s
    elsif direction == "v"
      coord = coord_primary.to_s + "_" + (start_coord + i).to_s
    else
      coord = (start_coord + i).to_s + "_" + (coord_primary + i).to_s
    end

    update_coord_occupation(coord)
  end
end

def determine_line_occupation(line_coordinates)
  # Only evaluate horizontal and vertical lines
  if is_diagonal?(line_coordinates) == false
    if is_horizontal?(line_coordinates)
      update_occupation(line_coordinates[0], line_coordinates[2], line_coordinates[1], "h")
    else
      update_occupation(line_coordinates[1], line_coordinates[3], line_coordinates[0], "v")
    end
  else
    update_occupation(line_coordinates[1], line_coordinates[3], [line_coordinates[0],line_coordinates[2]].min, "d")
  end
end

def determine_occupation(vents)
  vents.each do |vent_line|
    determine_line_occupation(vent_line)
  end
end

def determine_num_avoids(occupations)
  num_avoids = 0
  occupations.each do |key, value|
    if value > 1
      num_avoids += 1
    end
  end

  return num_avoids
end

parse_input('test_input.txt')
#puts "#{@vent_lines}"
#determine_occupation(@vent_lines)
#puts "#{@vent_occupation}"

#test_line = @vent_lines[5]
#puts "#{test_line}"
#update_occupation(test_line[0], test_line[2], [test_line[1],test_line[3]].min, "d")
#puts "#{@vent_occupation}"

#test_line2 = @vent_lines[8]
#puts "#{test_line2}"
#update_occupation(test_line2[0], test_line2[2], [test_line2[1],test_line2[3]].min, "d")
#puts "#{@vent_occupation}"

#test_line3 = @vent_lines[9]
#puts "#{test_line3}"
#update_occupation(test_line3[0], test_line3[2], [test_line3[1],test_line3[3]].min, "d")
#puts "#{@vent_occupation}"

test_line4 = @vent_lines[1]
puts "#{test_line4}"
update_occupation(test_line4[0], test_line4[2], [test_line4[1],test_line4[3]].min, "d")
puts "#{@vent_occupation}"
# I need to rethink my diagonal, as some of the slopes can be negative.

puts "# of most dangerous areas: #{determine_num_avoids(@vent_occupation)}"
