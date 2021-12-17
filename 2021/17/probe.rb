class Probe
  def initialize(coordinates, velocity)
    @x_coord = coordinates[0]
    @y_coord = coordinates[1]
    @x_velocity = velocity[0]
    @y_velocity = velocity[1]
  end

  def print_info
    puts "Coordinates: (#{@x_coord}, #{@y_coord})"
    puts "Velocity: (#{@x_velocity}, #{@y_velocity})"
  end

  def move
    step_x
    step_y
  end

  def step_x
    @x_coord += @x_velocity

    if @x_velocity > 0
      @x_velocity -= 1
    end
  end

  def step_y
    @y_coord += @y_velocity
    @y_velocity -= 1
  end

  def hit?(x_target_range, y_target_range)
    if @x_coord >= x_target_range[0] && @x_coord <= x_target_range[1]
      if @y_coord >= y_target_range[0] && @y_coord  <= y_target_range[1]
        return true
      end
    end

    return false
  end

  def inbounds?(x_target_range, y_target_range)
    if @x_coord <= x_target_range[1] && @y_coord  >= y_target_range[0]
      return true
    else
      return false
    end
  end
end