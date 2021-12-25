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

p parse_input('./data/test.txt')
