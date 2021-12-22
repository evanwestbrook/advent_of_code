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

def parse_input_2(file)
  reboot_steps = []
  File.readlines(file).each_with_index do |row, index|
    row = row.gsub(/\n/, "")
    # Get command
    commands = row.split(" ")
    step = {command: commands[0]}
    ranges = commands[1].split(",")

    # Get ranges for each direction
    do_range = []
    ranges.each do |range|
      direction = range.split("=")
      vals = direction[1].split("..")

      val_a = vals[0].to_i
      val_b = vals[1].to_i

      do_range << [[val_a, val_b].min(), [val_a, val_b].max()]
    end

    step[:ranges] = do_range

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
  if step[:x] && step[:y] && step[:z]
    step[:x].each do |x|
      step[:y].each do |y|
        step[:z].each do |z|
          if step[:command] == "on"
            reactor[x.to_s + "_" + y.to_s + "_" + z.to_s] = step[:command]
          else
            # Don't need to turn off reactor cubes that are already off
            if reactor[x.to_s + "_" + y.to_s + "_" + z.to_s]
              reactor[x.to_s + "_" + y.to_s + "_" + z.to_s] = step[:command]
            end
          end
        end
      end
    end
  end
end

def initialize_reactor(steps, reactor)
  steps.each_with_index do |step, index|
    truncate_ranges(step)
    process_step(step, reactor)
  end
end

def reboot_reactor(steps)
  total = 0
  prev_steps = []
  new_prev_steps = []

  steps.each do |step|
    prev_steps = new_prev_steps
    new_prev_steps = []
    xs = step[:ranges][0][0]
    xe = step[:ranges][0][1]
    ys = step[:ranges][1][0]
    ye = step[:ranges][1][1]
    zs = step[:ranges][2][0]
    ze = step[:ranges][2][1]

    if step[:command] == "on"
      total += (xe - xs + 1) * (ye - ys + 1) * (ze - zs + 1)
      new_prev_steps.append([-1, step[:ranges]])
    end

    prev_steps.each do |prev_step|
      new_prev_steps.append([prev_step[0], prev_step[1]])
      pxs = prev_step[1][0][0]
      pxe = prev_step[1][0][1]
      pys = prev_step[1][1][0]
      pye = prev_step[1][1][1]
      pzs = prev_step[1][2][0]
      pze = prev_step[1][2][1]

      mxe = [xe, pxe].min()
      mxs = [xs, pxs].max()
      mye = [ye, pye].min()
      mys = [ys, pys].max()
      mze = [ze, pze].min()
      mzs = [zs, pzs].max()

      if mxe > mxs && mye > mys && mze > mzs
        total += (mxe - mxs + 1) * (mye - mys + 1) * (mze - mzs + 1) * prev_step[0]
        new_prev_steps.append([-prev_step[0], [[mxs, mxe], [mys, mye], [mzs, mze]]])
      end
    end
  end

  return total
end

puts "===== STARTING ====="
$MIN_DIM = -50
$MAX_DIM = 50
@reboot_steps = parse_input('./data/input.txt')
@reboot_steps_2 = parse_input_2('./data/input.txt')
@reactor = {}

initialize_reactor(@reboot_steps, @reactor)
puts "Num on after initialization: #{@reactor.select { |key, value| value == "on"}.length}"
puts "Num on after reboot: #{reboot_reactor(@reboot_steps_2)}"
