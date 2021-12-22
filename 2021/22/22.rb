def parse_input(file)

  reboot_steps = []
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

    reboot_steps << step
  end

  return reboot_steps
end

def initialize_reactor
  reactor = {}

  Array(eval("-50..50")).each do |x|
    Array(eval("-50..50")).each do |y|
      Array(eval("-50..50")).each do |z|
        reactor[x.to_s + "_" + y.to_s + "_" + z.to_s] = "on"
      end
    end
  end

  return reactor
end

puts "===== STARTING ====="
@reboot_steps = parse_input('./data/test.txt')
@reactor = initialize_reactor
