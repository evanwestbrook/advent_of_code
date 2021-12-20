# https://www.reddit.com/r/adventofcode/comments/rjpf7f/comment/hp844vn/?utm_source=share&utm_medium=web2x&context=3
# https://gist.github.com/vincentwoo/dd1136e151c9035e090dd6401f301dcf

require 'matrix'
require 'set'

def permutations position
  (0..2).flat_map do |rot_idx|
    pos = position.rotate(rot_idx)
    [
      [ pos[0],  pos[1],  pos[2]],
      [ pos[0], -pos[1], -pos[2]],
      [ pos[0], -pos[2],  pos[1]],
      [ pos[0],  pos[2], -pos[1]],

      [-pos[0],  pos[1], -pos[2]],
      [-pos[0], -pos[2], -pos[1]],
      [-pos[0], -pos[1],  pos[2]],
      [-pos[0],  pos[2],  pos[1]],
    ]
  end.map { |pos| Vector[*pos] }
end

def find_offset s0, s1
  s1[0..13].product(s0).each do |s1_elem, s0_elem|
    offset = s0_elem - s1_elem
    return offset if s1.map { |e| e + offset }.intersection(s0).length >= 12
  end
end

def permute_by pos, perm_idx
  perms = permutations [1, 2, 3]
  perms[perm_idx].map { |i| i < 0 ? -pos[(-i) - 1] : pos[i - 1] }
end

def parse_input(file)
  input = File.read(file)

  scanners = input.split("\n\n").map { |scanner|
    scanner
      .split("\n")[1..-1]
      .map { |line| line.split(',').map(&:to_i) }
      .map { |pos| permutations pos }.transpose
  }

  return scanners
end

def get_fingerprints(scanners)
  scanner_fingerprints = scanners.map { |scanner_perms|
    scanner_perms.map do |perm|
      perm.map do |elem|
        (perm - [elem]).map { |_elem| elem - _elem }.min_by &:magnitude
      end
    end
  }

  return scanner_fingerprints
end

def get_mappings(scanners, scanner_fingerprints)
  mappings = (0...scanners.length).to_a.permutation(2).map {|a, b|
    s0 = scanner_fingerprints[a][0]
    s1 = scanner_fingerprints[b]
    if perm_idx = s1.find_index { |_s1| _s1.intersection(s0).length >= 12 }
      [a, b, perm_idx,
        find_offset(scanners[a][0], scanners[b][perm_idx])
      ]
    end
  }.compact

  return mappings
end

def find_scanner_positions(scanners, mappings)
  scanner_positions = [Vector[0, 0, 0]]
  canonicalized_beacons = scanners[0][0]
  transform_chain = {0 => []}
  until transform_chain.length == scanners.length
    mapping = mappings.find { |_s0_idx, _s1_idx|
      transform_chain.include?(_s0_idx) &&
      !transform_chain.include?(_s1_idx)
    }

    s0_idx, s1_idx, perm_idx, offset = mapping
    transform_chain[s1_idx] = [[perm_idx, offset]] + transform_chain[s0_idx]

    s1 = [offset] + scanners[s1_idx][perm_idx].map { |elem| elem + offset }
    transform_chain[s0_idx].each do |perm_idx, offset|
      s1.map! { |elem| permute_by(elem, perm_idx) + offset }
    end
    scanner_positions.push s1.shift
    canonicalized_beacons = (canonicalized_beacons + s1).uniq
  end

  return {beacons: canonicalized_beacons, scanners: scanner_positions}
end

@scanners = parse_input('./data/input.txt')
@scanner_fingerprints = get_fingerprints(@scanners)
@scanner_mappings = get_mappings(@scanners, @scanner_fingerprints)
@equipment_locations =  find_scanner_positions(@scanners, @scanner_mappings)

puts "There are #{@equipment_locations[:beacons].length} beacons"
puts "The largest Manhattan distance between two scanners is #{@equipment_locations[:scanners].combination(2).map { |a, b| (b-a).map(&:abs).sum }.max}"
