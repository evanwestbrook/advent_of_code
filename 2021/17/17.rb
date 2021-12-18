require './probe.rb'

# Start at lowest height we could be at (with the minimum x?)
# keep backing off x and increasing y until we miss
# one right before that will be the solution
@hit_velocities = {}

def parse_input(file)
  File.readlines(file).each do |row|
    instructions = row.gsub("\n", '')
    instructions = instructions.split(",")
    @x_range = instructions[0].split("x=")[1].split("..").map { |s| s.to_i}
    @y_range = instructions[1].split("y=")[1].split("..").map { |s| s.to_i}
  end
end

def fire_probe(velocity)
  probe = Probe.new([0,0], velocity)

  while probe.inbounds?(@x_range, @y_range)
    probe.move

    if probe.hit?(@x_range, @y_range)
      return { hit: true, probe: probe }
    end
  end

  if !probe.inbounds?(@x_range, @y_range)
    return { hit: false, probe: probe }
  end
end

def find_all_velocities
  x = 0
  y = 0
  1000.times do |i|
    if fire_probe([x + i, y])[:hit]
      if @hit_velocities[(x + i).to_s + "_" + y.to_s]
        @hit_velocities[(x + i).to_s + "_" + y.to_s] = @hit_velocities[(x + i).to_s + "_" + y.to_s] + 1
      else
        @hit_velocities[(x + i).to_s + "_" + y.to_s] = 1
      end
    end
    check_y(x + i, y)
  end
end

def check_y(x, y)
  1000.times do |i|
    if fire_probe([x, y + i])[:hit]
      if @hit_velocities[x.to_s + "_" + (y + i).to_s]
        @hit_velocities[x.to_s + "_" + (y + i).to_s] = @hit_velocities[x.to_s + "_" + (y + i).to_s] + 1
      else
        @hit_velocities[x.to_s + "_" + (y + i).to_s] = 1
      end
    end
  end
  1000.times do |i|
    if fire_probe([x, y - i])[:hit]
      if @hit_velocities[x.to_s + "_" + (y - i).to_s]
        @hit_velocities[x.to_s + "_" + (y - i).to_s] = @hit_velocities[x.to_s + "_" + (y - i).to_s] + 1
      else
        @hit_velocities[x.to_s + "_" + (y - i).to_s] = 1
      end
    end
  end
end

puts "===== STARTING ====="
parse_input('./data/input.txt')
find_all_velocities
puts "Hit velocities #{@hit_velocities}"
puts "Hit velocities #{@hit_velocities.length}"
