# Each step
# east try to move
# south try to move
# Can only move if htere is an open space in front of it
# right boundary moves to the left boundary
# bottom boundary moves to teh top boundary
# Solution: find when sea cucumbers stop moving (all blocked)

def parse_input(file)
  sea_cucumbers = []
  File.readlines(file).each do |row|
    row = row.gsub(/\n/, "")
    row = row.split("")
    cucumber_row = []
    row.each do |cucumber|
      cucumber_row << cucumber
    end

    sea_cucumbers << cucumber_row

  end

  return sea_cucumbers
end

def print_cucumbers(sea_cucumbers)
  sea_cucumbers.each do |cucumber_row|
    print_row = ""
    cucumber_row.each do |cucumber|
      print_row += cucumber
    end

    puts print_row
  end
end

def step_east(sea_cucumbers)
  sea_cucumbers.each do |cucumber_row|
    # Duplicate row for comparison so cucumbers only move 1 space per step
    old_row = cucumber_row.dup
    old_row.each_with_index do |cucumber, index|
      # If it moves east
      if cucumber == ">"
        # check boundary case
        if index == old_row.length - 1
          # if it can move east
          if old_row[0] == "."
            cucumber_row[0] = ">"
            cucumber_row[index] = "."
          end
        else
          if old_row[index + 1] == "."
            cucumber_row[index + 1] = ">"
            cucumber_row[index] = "."
          end
        end
      end
    end
  end
end

def step_south(sea_cucumbers)
  num_cols = sea_cucumbers[0].length
  num_rows = sea_cucumbers.length

  num_cols.times do |i|

    # Create an array of col values because this parses better for some reason
    my_col = []
    num_rows.times do |j|
      my_col << sea_cucumbers[j][i]
    end

    my_col.each_with_index do |cucumber, index|
      # If it moves south
      if cucumber == "v"
        # check boundary case
        if index == my_col.length - 1
          # if it can move south
          if my_col[0] == "."
            sea_cucumbers[0][i] = "v"
            sea_cucumbers[index][i] = "."
          end
        else
          if my_col[index + 1] == "."
            sea_cucumbers[index + 1][i] = "v"
            sea_cucumbers[index][i] = "."
          end
        end
      end
    end
  end
end

puts "===== STARTING ====="

@sea_cucumbers = parse_input('./data/test.txt')
print_cucumbers(@sea_cucumbers)
puts "STEP 1 a"
step_east(@sea_cucumbers)
print_cucumbers(@sea_cucumbers)
puts "STEP 1 b"
step_south(@sea_cucumbers)
print_cucumbers(@sea_cucumbers)
