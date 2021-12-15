def left_boundary?(col_index)
  if (col_index - 1) < 0
    return true
  else
    return false
  end
end

def right_boundary?(rows, row_index, col_index)
  if col_index + 1 > rows[row_index].length - 1
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

def bottom_boundary?(rows, row_index)
  if row_index + 1 > rows.length - 1
    return true
  else
    return false
  end
end
