#https://github.com/mebeim/aoc/blob/master/2021/original_solutions/day19.py
# https://www.reddit.com/r/adventofcode/comments/rjpf7f/comment/hp5nnej/?utm_source=share&utm_medium=web2x&context=3

require './matrix_math.rb'

def parse_input(file)
  @scanners = []
  scanner = {}
  scanner_num = 0
  file_lines = File.readlines(file)

  file_lines.each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    if row.include? "---"
      if index > 0
        @scanners << scanner
      end
      scanner = {}
      row = row.split(" ")
      scanner_num = row[2].to_i
      scanner[scanner_num] = []
    elsif row.include? ","
      row = row.split(",")
      row = row.map{ |coord| coord = coord.to_i}
      scanner[scanner_num] << row
    end

    if index == file_lines.length - 1
      @scanners << scanner
    end
  end
end

bases = get_bases


p bases
p bases.length

parse_input('./data/test_input_2.txt')
