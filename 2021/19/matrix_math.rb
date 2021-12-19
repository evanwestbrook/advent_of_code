@facings = [
	[0, 0, 0],
  [90, 0, 0],
	[180, 0, 0],
	[270, 0, 0],
	[0, 90, 0],
	[90, 90, 0],
	[180, 90, 0],
	[270, 90, 0],
	[0, 180, 0],
	[90, 180, 0],
	[180, 180, 0],
	[270, 180, 0],
	[0, 270, 0],
	[90, 270, 0],
	[180, 270, 0],
	[270, 270, 0],
	[0, 0, 90],
	[90, 0, 90],
	[180, 0, 90],
	[270, 0, 90],
	[0, 0, 270],
	[90, 0, 270],
	[180, 0, 270],
	[270, 0, 270],
]

@vbase = [[1, 0, 0], [0, 1, 0], [0, 0, 1]]

def cos(x)
  if x == 90
    return 0
  elsif x == 180
    return -1
  elsif x == 270
    return 0
  elsif x == 0
    return 1
  end
end

def sin(x)
  if x == 90
    return 1
  elsif x == 180
    return 0
  elsif x == 270
    return -1
  elsif x == 0
    return 0
  end
end

def rotate3d_z(x, y, z, theta)
  c, s = cos(theta), sin(theta)
  return [x * c - y * s, x * s + y * c, z]
end

def rotate3d_x(x, y, z, theta)
  c, s = cos(theta), sin(theta)
  return [x, y * c - z * s, y * s + z * c]
end

def rotate3d_y(x, y, z, theta)
  c, s = cos(theta), sin(theta)
  return [x * c + z * s, y, -x * s + z * c]
end

def apply_rotation(vbase, facing)
  rx = facing[0]
  ry = facing[1]
  rz = facing[2]
  matrix = []

  vbase.each do |base|
    rotated_x = rotate3d_x(base[0], base[1], base[2], rx)
    rotated_y = rotate3d_y(rotated_x[0], rotated_x[1], rotated_x[2], ry)
    rotated_z = rotate3d_z(rotated_y[0], rotated_y[1], rotated_y[2], rz)
    matrix << rotated_z
  end

  return matrix
end

def basis_transform(coordinate, basis)
  a = basis[0][0]
  b = basis[0][1]
  c = basis[0][2]
  d = basis[1][0]
  e = basis[1][1]
  f = basis[1][2]
  g = basis[2][0]
  h = basis[2][1]
  i = basis[2][2]
  x = coordinate[0]
  y = coordinate[0]
  z = coordinate[0]

  return [a * x + b * y + c * z, d * x + e * y + f * z, g * x + h * y + i * z]
end

def diff(a, b)
  ax = a[0]
  ay = a[1]
  az = a[2]
  bx = b[0]
  by = b[1]
  bz = b[2]

  return [ax - bx, ay - by, az - bz]
end

def add(a, b)
  ax = a[0]
  ay = a[1]
  az = a[2]
  bx = b[0]
  by = b[1]
  bz = b[2]

  return [ax + bx, ay + by, az + bz]
end

def manhattan(a, b)
  ax = a[0]
  ay = a[1]
  az = a[2]
  bx = b[0]
  by = b[1]
  bz = b[2]

  return (ax - bx).abs() + (ay - by).abs() + (az - bz).abs()
end

def get_bases
  bases = []

  @facings.each do |facing|
    bases << apply_rotation(@vbase, facing)
  end

  return bases
end

