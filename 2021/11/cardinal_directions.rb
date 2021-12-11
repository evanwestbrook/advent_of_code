def get_w(row_index, col_index)
  if (col_index - 1) < 0 # handle left boundary
    return 99
  else
    return @rows[row_index][col_index - 1]
  end
end

def get_e(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1  # handle right boundary
    return 99
  else
    return @rows[row_index][col_index + 1]
  end
end

def get_n(row_index, col_index)
  if (row_index - 1) < 0 # handle top boundary
    return 99
  else
    return @rows[row_index - 1][col_index]
  end
end

def get_s(row_index, col_index)
  if row_index + 1 > @rows.length - 1  # handle bottom boundary
    return 99
  else
    return @rows[row_index + 1][col_index]
  end
end

def get_nw(row_index, col_index)
  if (col_index - 1) < 0 || (row_index - 1) < 0 # handle left and top boundary
    return 99
  else
    return @rows[row_index - 1][col_index - 1]
  end
end

def get_ne(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1 || (row_index - 1) < 0 # handle right and top boundary
    return 99
  else
    return @rows[row_index - 1][col_index + 1]
  end
end

def get_sw(row_index, col_index)
  if (col_index - 1) < 0 || row_index + 1 > @rows.length - 1 # handle left and bottom boundary
    return 99
  else
    return @rows[row_index + 1][col_index - 1]
  end
end

def get_se(row_index, col_index)
  if (col_index + 1) > @rows[row_index].length - 1 || row_index + 1 > @rows.length - 1 # handle right and bottom boundary
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
