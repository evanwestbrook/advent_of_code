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
  slope = (coord_primary[0] - coord_primary[1]) / (coord_1 - coord_2)

  (end_coord - start_coord + 1).times do |i|
    coord = ""
    if direction == "h"
      coord = (start_coord + i).to_s + "_" + coord_primary.to_s
    elsif direction == "v"
      coord = coord_primary.to_s + "_" + (start_coord + i).to_s
    else

      if coord_1 >= coord_2 && slope > 0
        coord = (coord_1 - i).to_s + "_" + ([coord_primary[0], coord_primary[1]].max - i).to_s
      elsif coord_2 >= coord_1 && slope > 0
        coord = (coord_1 + i).to_s + "_" + ([coord_primary[0], coord_primary[1]].min + i).to_s
      elsif  coord_2 >= coord_1 && slope < 0
        coord = (coord_1 + i).to_s + "_" + ([coord_primary[0], coord_primary[1]].max - i).to_s
      else
        coord = (coord_1 - i).to_s + "_" + ([coord_primary[0], coord_primary[1]].min + i).to_s
      end
    end

    update_coord_occupation(coord)
  end
end

def determine_line_occupation(line_coordinates)
  if is_diagonal?(line_coordinates) == false
    if is_horizontal?(line_coordinates)
      update_occupation(line_coordinates[0], line_coordinates[2], line_coordinates[1], "h")
    else
      update_occupation(line_coordinates[1], line_coordinates[3], line_coordinates[0], "v")
    end
  else
    update_occupation(line_coordinates[0], line_coordinates[2], [line_coordinates[1],line_coordinates[3]], "d")
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

parse_input('input.txt')
determine_occupation(@vent_lines)

puts "# of most dangerous areas: #{determine_num_avoids(@vent_occupation)}"
