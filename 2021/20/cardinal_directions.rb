def left_boundary?(col_index)
  if (col_index - 1) < 0
    return true
  else
    return false
  end
end

def right_boundary?(input_image, col_index, row_index)
  if (col_index + 1) > input_image[row_index].length - 1
    return true
  else
    return false
  end
end

def top_boundary?(row_index)
  if (row_index - 1) < 0
    return true
  else
    return false
  end
end

def bottom_boundary?(input_image, row_index)
  if row_index + 1 > input_image.length - 1
    return true
  else
    return false
  end
end

def get_w(input_image, row_index, col_index)
  if left_boundary?(col_index)
    return "."
  else
    return input_image[row_index][col_index - 1]
  end
end

def get_e(input_image, row_index, col_index)
  if right_boundary?(input_image, col_index, row_index)
    return "."
  else
    return input_image[row_index][col_index + 1]
  end
end

def get_n(input_image, row_index, col_index)
  if top_boundary?(row_index)
    return "."
  else
    return input_image[row_index - 1][col_index]
  end
end

def get_s(input_image, row_index, col_index)
  if bottom_boundary?(input_image, row_index)
    return "."
  else
    return input_image[row_index + 1][col_index]
  end
end

def get_nw(input_image, row_index, col_index)
  if top_boundary?(row_index) || left_boundary?(col_index)
    return "."
  else
    return input_image[row_index - 1][col_index - 1]
  end
end

def get_ne(input_image, row_index, col_index)
  if top_boundary?(row_index) || right_boundary?(input_image, col_index, row_index)
    return "."
  else
    return input_image[row_index - 1][col_index + 1]
  end
end

def get_sw(input_image, row_index, col_index)
  if bottom_boundary?(input_image, row_index) || left_boundary?(col_index)
    return "."
  else
    return input_image[row_index + 1][col_index - 1]
  end
end

def get_se(input_image, row_index, col_index)
  if bottom_boundary?(input_image, row_index) || right_boundary?(input_image, col_index, row_index)
    return "."
  else
    return input_image[row_index + 1][col_index + 1]
  end
end

def get_adjacent(input_image, row_index, col_index)
  return {
    w: get_w(input_image, row_index, col_index),
    e: get_e(input_image, row_index, col_index),
    n: get_n(input_image, row_index, col_index),
    s: get_s(input_image, row_index, col_index),
    nw: get_nw(input_image, row_index, col_index),
    ne: get_ne(input_image, row_index, col_index),
    sw: get_sw(input_image, row_index, col_index),
    se: get_se(input_image, row_index, col_index)
  }
end
