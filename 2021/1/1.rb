def file_to_array(file)
  read_file = File.readlines(file)
  @array = []

  read_file.each do |line|
    @array << line.to_i
  end
end

file_to_array('input.txt')
