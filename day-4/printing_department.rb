input = File.read('day-4/input.txt')

def parse_input_to_2d_array(input)
  input.split("\n").map do |row|
    row.chars
  end
end

def find_neighbours(x, y, array)
  neighbours = []
  directions = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1],          [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  directions.each do |dx, dy|
    new_x = x + dx
    new_y = y + dy
    if new_x.between?(0, array.length - 1) && new_y.between?(0, array[0].length - 1)
      neighbours << array[new_x][new_y]
    end
  end

  neighbours
end

array_2d = parse_input_to_2d_array(input)
# puts find_neighbours(0, 0, array_2d).inspect

def find_all_neighbours(array)
  all_neighbours = []
  array.each_with_index do |row, x|
    row.each_with_index do |_, y|
      all_neighbours << { position: [x, y], neighbours: find_neighbours(x, y, array) }
    end
  end
  all_neighbours
end

# puts all_neighbours = find_all_neighbours(array_2d).inspect

def count_liftable_rolls(array)
  liftable_rolls = []
  find_all_neighbours(array).each do |cell|
    if array[cell[:position][0]][cell[:position][1]] == '@' && cell[:neighbours].filter { |n| n == '@' }.length < 4
      liftable_rolls << cell

    end
  end

  liftable_rolls.length
end

def remove_liftable_rolls(array)
  new_array = array.map(&:dup)
  find_all_neighbours(array).each do |cell|
    if array[cell[:position][0]][cell[:position][1]] == '@' && cell[:neighbours].filter { |n| n == '@' }.length < 4
      new_array[cell[:position][0]][cell[:position][1]] = '.'
    end
  end
  new_array
end

def process_liftable_rolls(array)
  current_array = array
  total_liftable_count = 0
  loop do
    liftable_count = count_liftable_rolls(current_array)
    break if liftable_count == 0
    total_liftable_count += liftable_count

    current_array = remove_liftable_rolls(current_array)
  end
  total_liftable_count
end

puts "Liftable rolls: #{count_liftable_rolls(array_2d)}"
puts "Total liftable rolls after processing: #{process_liftable_rolls(array_2d)}"