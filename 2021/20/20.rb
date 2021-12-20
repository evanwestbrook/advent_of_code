require './cardinal_directions.rb'

@enhancement_algo = ""
@input_image = []

#each step consdiers growing one outwards on all sides

def parse_input(file)
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
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

def get_enhancement_arr(input_image, x, y)
  neighbors = get_adjacent(input_image, y, x)

  top_row = [neighbors[:nw], neighbors[:n], neighbors[:ne]]
  p top_row
  mid_row = [neighbors[:w], input_image[y][x], neighbors[:e]]
  p mid_row
  bottom_row = [neighbors[:sw], neighbors[:s], neighbors[:se]]
  p bottom_row
end

def enhance_pixel(x, y)
end

parse_input('./data/test_input.txt')

get_enhancement_arr(@input_image, 2, 2)
