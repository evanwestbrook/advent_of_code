#https://github.com/mebeim/aoc/blob/master/2021/original_solutions/day19.py
#https://www.reddit.com/r/adventofcode/comments/rjpf7f/comment/hp5nnej/?utm_source=share&utm_medium=web2x&context=3

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

@MATCH_THRESHOLD = 12

def common_points(s1, s2, i1, i2)
  @bases.each do |basis|
    new_s2 = []
    s2.each do |vec|
      new_s2 << basis_transform(vec, basis)
    end

   s1.product(new_s2).each do |point|
    dist = diff(point[1], point[1])

    translated_s2 = []
    new_s2.each do |p|
      translated_s2 << add(p, dist)
      if (sl + translated_s2).length >= MATCH_THRESHOLD
        return [translated_s2, dist]
      end
    end
   end


  end
end

puts "===== STARTING ====="
@bases = get_bases



parse_input('./data/test_input_2.txt')
