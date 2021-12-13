@starting_dots = {}
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
      if !@starting_dots[row[0] + "_" + row[1]]
        @starting_dots[row[0] + "_" + row[1]] = [row[0].to_i, row[1].to_i]
      end
    end

    # Handle fold instructions
    if row.include? "fold"
      row = row.split("=")
      @folds << { row[0].split(" ")[-1]=> row[1].to_i }
    end
  end
end

parse_input('test_input.txt')
puts "#{@starting_dots}"
puts "#{@folds}"
