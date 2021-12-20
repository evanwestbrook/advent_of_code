require './cardinal_directions.rb'

@enhancement_algo = ""
@input_image = []

#each step consdiers growing one outwards on all sides

def parse_input(file)
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    # Get enhancement algorithm
    if index == 0
      @enhancement_algo = row
    elsif row.include? "."

      row_arr = []
      row.length.times do |i|
        row_arr << row[i]
      end
      @input_image << row_arr
    end
  end
end

def print_image(image)
  image.each do |row|
    p_row = row.join("")
    puts p_row
  end
end

def get_enhancement_arr(input_image, x, y)
  neighbors = get_adjacent(input_image, y, x)

  top_row = [neighbors[:nw], neighbors[:n], neighbors[:ne]]
  mid_row = [neighbors[:w], input_image[y][x], neighbors[:e]]
  bottom_row = [neighbors[:sw], neighbors[:s], neighbors[:se]]

  return [top_row, mid_row, bottom_row]
end

def decode_enhancement_arr(enhancement_arr)
  binary = ""
  enhancement_arr.each do |row|
    row.each do |col|
      if col == "."
        binary += "0"
      else
        binary += "1"
      end
    end
  end

  return binary.to_i(2)
end

def enhance_pixel(input_image, x, y)
  return @enhancement_algo[decode_enhancement_arr(get_enhancement_arr(input_image, x, y))]
end

parse_input('./data/test_input.txt')
print_image(@input_image)

#p enhance_pixel(@input_image, 2, 2)

