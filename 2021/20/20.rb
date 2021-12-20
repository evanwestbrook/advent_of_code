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


def simulate_infinite_space(input_image)

  new_image = input_image.dup

  # Add padding to top
  2.times do
    pre_row = [".", ".", ".", "."]
    input_image[0].length.times do |i|
      pre_row << "."
    end
    new_image.unshift(pre_row)
  end

  # Add padding to mid
  input_image.each do |row|
    2.times do
      row.unshift(".")
      row.push(".")
    end
  end

  # Add padding to bottom
  2.times do
    pre_row = []
    input_image[0].length.times do |i|
      pre_row << "."
    end
    new_image.push(pre_row)
  end

  return new_image
end


def enhance_pixel(input_image, x, y)
  return @enhancement_algo[decode_enhancement_arr(get_enhancement_arr(input_image, x, y))]
end

def enhance_image(input_image)
  new_image = []

  infinite_image = simulate_infinite_space(input_image)

  infinite_image.each_with_index do |row, i|
    new_row = []
    row.each_with_index do |col, j|
      new_col = enhance_pixel(infinite_image, j, i)
      new_row << new_col
    end
    new_image << new_row
  end

  return new_image
end

def enhance(input_image, n)
  new_image = input_image.dup

  n.times do
    new_image = enhance_image(new_image)
  end

  return new_image
end

def get_num_lit(input_image)
  num_lit = 0
  input_image.each do |row|
    num_lit += row.count("#")
  end

  return num_lit
end

parse_input('./data/test_input.txt')

puts "The # of lit pixels is #{get_num_lit(enhance(@input_image, 2))}"
