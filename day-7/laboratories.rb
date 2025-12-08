input = File.read("day-7/input.txt").split("\n").map { |line| line.chars }

def trace_tachyon_beams(input)
  light_source = input[0].index('S')
  current_beam_locations = Set.new([light_source])
  answer = 0

  input[1..].each_with_index do |line, index|
    next unless line.include?('^')
    new_locations = Set.new([])

    current_beam_locations.clone.each do |location|
      if line[location] == '.' 
        next 
      elsif line[location] == '^'
        answer += 1

        new_locations << location - 1
        new_locations << location + 1
        current_beam_locations.delete(location)
      end
    end

    puts "new locations #{new_locations} to be added to #{current_beam_locations}"
    puts "current answer: #{answer}"

    current_beam_locations.merge(new_locations)
  end

  answer
end

def trace_all_possible_beam_paths(input)
  light_source = input[0].index('S')
  current_paths = [[[0, light_source]]]

  input[1..].each_with_index do |line, row_index|
    actual_row = row_index + 1
    next_paths = []

    current_paths.each do |path|
      last_col = path[-1][1]
      next if last_col < 0 || last_col >= line.size

      if line[last_col] == '^'
        left_path = path + [[actual_row, last_col - 1]]
        right_path = path + [[actual_row, last_col + 1]]
        next_paths << left_path
        next_paths << right_path
      else
        new_path = path + [[actual_row, last_col]]
        next_paths << new_path
      end
    end

    current_paths = next_paths
  end

  # Remove duplicate paths and count them
  current_paths.size
end

puts trace_all_possible_beam_paths(input).inspect