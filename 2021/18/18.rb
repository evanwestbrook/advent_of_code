def parse_snailfish_number(snailfish_number)
  # Parse number into ruby complex number of a+bi where a is number and b is depth
  depth = 0
  parsed_number = []

  snailfish_number.chars.each do |char|
    if char.match?(/\d/)
      parsed_number << char.to_i + depth.i
    elsif char == "["
      depth += 1
    elsif char == "]"
      depth -= 1
    end
  end

  return parsed_number
end

def add(left, right)
  joined = left.dup.concat(right).map{_1 + 1.i}
  loop do
    index_to_explode = joined.index{_1.imaginary >= 5}
    if index_to_explode
      explode(joined, index_to_explode) and next
    end
    index_to_split = joined.index{_1.real >= 10}
    if index_to_split
      split(joined, index_to_split) and next
    end
    break
  end
  return joined
end

def split(sf_num, index)
  sf_num.insert(index + 1, (sf_num[index].real / 2.0).round + (sf_num[index].imaginary + 1).i)
  sf_num[index] = sf_num[index].real / 2 + (sf_num[index].imaginary + 1).i
end

def explode(sf_num, index)
  first, second = sf_num.slice(index, 2)
  sf_num[index - 1] += first.real if index != 0
  sf_num[index + 2] += second.real if sf_num[index + 2]
  sf_num.delete_at(index)
  sf_num[index] = 0 + (first.imaginary - 1).i
end

def get_magnitude(sf_num)
  loop do
    max_depth = sf_num.map(&:imaginary).max
    break if max_depth == 0

    index = sf_num.index{_1.imaginary == max_depth}
    sf_num[index] = 3 * sf_num[index].real + 2 * sf_num[index + 1].real + (sf_num[index].imaginary - 1).i
    sf_num.delete_at(index + 1)
  end

  return sf_num.first.real
end

snailfish_numbers = open("input.txt").each_line.map{parse_snailfish_number(_1)}


