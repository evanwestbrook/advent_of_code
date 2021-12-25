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

  num_cols.times do |i|
    sea_cucumbers.each_with_index do |cucumber_row, index|
    end
  end
end

puts "===== STARTING ====="

@sea_cucumbers = parse_input('./data/test.txt')
p @sea_cucumbers
step_east(@sea_cucumbers)
p @sea_cucumbers
step_south(@sea_cucumbers)
