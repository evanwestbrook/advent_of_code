require './cardinal_directions.rb'

@enhancement_algo = ""
@input_image = []

def parse_input(file)
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    # Get enhancement algorithm
    if index == 0
      @enhancement_algo = row
    # Parse out the image
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

def get_enhancement_arr(input_image, x, y, padding_char)
  neighbors = get_adjacent(input_image, y, x, padding_char)

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


def simulate_infinite_space(input_image, padding_char)
  new_image = input_image.dup

  # Add padding to top
  2.times do
    pre_row = [padding_char, padding_char, padding_char, padding_char]
    input_image[0].length.times do |i|
      pre_row << padding_char
    end
    new_image.unshift(pre_row)
  end

  # Add padding to mid
  input_image.each do |row|
    2.times do
      row.unshift(padding_char)
      row.push(padding_char)
    end
  end

  # Add padding to bottom
  2.times do
    post_row = []
    input_image[0].length.times do |i|
      post_row << padding_char
    end
    new_image.push(post_row)
  end

  return new_image
end


def enhance_pixel(input_image, x, y, padding_char)
  return @enhancement_algo[decode_enhancement_arr(get_enhancement_arr(input_image, x, y, padding_char))]
end

def enhance_image(input_image, padding_char)
  new_image = []

  infinite_image = simulate_infinite_space(input_image, padding_char)

  infinite_image.each_with_index do |row, i|
    new_row = []
    row.each_with_index do |col, j|
      new_col = enhance_pixel(infinite_image, j, i, padding_char)
      new_row << new_col
    end
    new_image << new_row
  end

  return new_image
end

def enhance(input_image, n)
  new_image = input_image.dup

  padding_char = "."
  flicker_char = "."
  # If empty space (000000000) is not decoded as "." then the infinite space flickers between "." and "#"
  if @enhancement_algo[0] == "#"
    flicker_char = "#"
  end

  n.times do |i|
    if i.odd?
      new_image = enhance_image(new_image, flicker_char)
    else
      new_image = enhance_image(new_image, padding_char)
    end
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
