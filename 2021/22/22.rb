@reboot_steps = []

def parse_input(file)
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    # Get command
    commands = row.split(" ")
    step = {command: commands[0]}
    ranges = commands[1].split(",")

    # Get ranges for each direction
    ranges.each do |range|
      range = range.split("=")
      step[range[0].to_sym] = Array(eval(range[1]))
    end

    @reboot_steps << step
  end
end

parse_input('./data/test.txt')
