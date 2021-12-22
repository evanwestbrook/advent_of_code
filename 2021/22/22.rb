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
      direction = range.split("=")
      vals = direction[1].split("..")
      val_a = vals[0].to_i
      val_b = vals[1].to_i

      eval_range = [val_a, val_b].min().to_s + ".." + [val_a, val_b].max().to_s

      step[direction[0].to_sym] = Array(eval(direction[1]))
    end

    reboot_steps << step
  end

  return reboot_steps
end

def eval_range(step_range)
  x_min = step_range.min()
  x_max = step_range.max()

  # handle out of range
  if (x_min < $MIN_DIM && x_max < $MIN_DIM) || (x_min > $MAX_DIM && x_max < $MAX_DIM)
    return nil
  else
    if x_min < $MIN_DIM
      x_min = $MIN_DIM
    end
    if x_max > $MAX_DIM
      x_max = $MAX_DIM
    elsif x_max < $MIN_DIM
      x_max = $MIN_DIM
    end

    range = x_min.to_s + ".." + x_max.to_s

    return Array(eval(range))
  end
end

def truncate_ranges(step)

  step[:x] = eval_range(step[:x])
  step[:y] = eval_range(step[:y])
  step[:z] = eval_range(step[:z])

end

def process_step(step, reactor)
  # Check if all step directions are in range
  truncate_ranges(step)

  if step[:x] && step[:y] && step[:z]
    step[:x].each do |x|
      step[:y].each do |y|
        step[:z].each do |z|
          reactor[x.to_s + "_" + y.to_s + "_" + z.to_s] = step[:command]
        end
      end
    end
  end
end

def initialize_reactor(steps, reactor)
  steps.each do |step|
    process_step(step, reactor)
  end
end

puts "===== STARTING ====="
$MIN_DIM = -50
$MAX_DIM = 50
@reboot_steps = parse_input('./data/input.txt')
@reactor = {}

initialize_reactor(@reboot_steps, @reactor)
puts "Num on after initialization: #{@reactor.select { |key, value| value == "on"}.length}"
