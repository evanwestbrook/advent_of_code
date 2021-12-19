def parse_input(file)
  @scanners = []
  scanner = {}
  scanner_num = 0
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    if row.include? "---"
      if index > 0
        @scanners << scanner
      end
      scanner = {}
      scanner_num = 0
      row = row.split(" ")
      scanner_num = row[2].to_i
      scanner[scanner_num] = []
    elsif row.include? ","
      row = row.split(",")
      row = row.map{ |coord| coord = coord.to_i}
      scanner[scanner_num] << row
    end

    #instructions = instructions.split(",")
    #@x_range = instructions[0].split("x=")[1].split("..").map { |s| s.to_i}
    #@y_range = instructions[1].split("y=")[1].split("..").map { |s| s.to_i}
  end
end

parse_input('./data/test_input_2.txt')
puts "#{@scanners}"
