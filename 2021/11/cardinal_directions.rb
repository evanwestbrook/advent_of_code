def left_boundary?(col_index)
  if (col_index - 1) < 0
    return true
  else
    return false
  end
end

def right_boundary?(col_index, row_index)
  if (col_index + 1) > @rows[row_index].length - 1
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

def bottom_boundary?(row_index)
  if row_index + 1 > @rows.length - 1
    return true
  else
    return false
  end
end

def get_w(row_index, col_index)
  if left_boundary?(col_index)
    return 99
  else
    return @rows[row_index][col_index - 1]
  end
end

def get_e(row_index, col_index)
  if right_boundary?(col_index, row_index)
    return 99
  else
    return @rows[row_index][col_index + 1]
  end
end

def get_n(row_index, col_index)
  if top_boundary?(row_index)
    return 99
  else
    return @rows[row_index - 1][col_index]
  end
end

def get_s(row_index, col_index)
  if bottom_boundary?(row_index)
    return 99
  else
    return @rows[row_index + 1][col_index]
  end
end

def get_nw(row_index, col_index)
  if left_boundary?(col_index) || top_boundary?(row_index)
    return 99
  else
    return @rows[row_index - 1][col_index - 1]
  end
end

def get_ne(row_index, col_index)
  if right_boundary?(col_index, row_index) || top_boundary?(row_index)
    return 99
  else
    return @rows[row_index - 1][col_index + 1]
  end
end

def get_sw(row_index, col_index)
  if left_boundary?(col_index) || bottom_boundary?(row_index)
    return 99
  else
    return @rows[row_index + 1][col_index - 1]
  end
end

def get_se(row_index, col_index)
  if right_boundary?(col_index, row_index) || bottom_boundary?(row_index)
    return 99
  else
    return @rows[row_index + 1][col_index + 1]
  end
end

def get_adjacent(row_index, col_index)
  return {
    w: get_w(row_index, col_index),
    e: get_e(row_index, col_index),
    n: get_n(row_index, col_index),
    s: get_s(row_index, col_index),
    nw: get_nw(row_index, col_index),
    ne: get_ne(row_index, col_index),
    sw: get_sw(row_index, col_index),
    se: get_se(row_index, col_index)
  }
end
