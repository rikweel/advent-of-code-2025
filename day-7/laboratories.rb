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

puts trace_tachyon_beams(input)