@enhancement_algo = ""
@input_image = []

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

parse_input('./data/test_input.txt')
