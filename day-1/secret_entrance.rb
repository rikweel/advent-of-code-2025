class SecretEntranceOpener
  def initialize(rotations, dial_length = 100, starting_position = 50)
    @rotations = rotations
    @dial_length = dial_length
    @starting_position = starting_position
  end

  def create_dial
    dial = Array.new(@dial_length) { |i| i } 
    dial.rotate!(@starting_position)
    return dial
  end

  def solve_secret_code_1
    answer = 0
    dial = create_dial

    @rotations.each do |rotation|
      if rotation[0] == 'L'
        dial.rotate!(rotation[1..-1].to_i)
      else
        dial.rotate!(-rotation[1..-1].to_i)
      end

      dial[0].zero? && answer += 1
    end

    answer
  end

  def count_points_at_zero(position, total_rotations)
    count = 0
    full_rotations = ((position.to_f + total_rotations) / @dial_length).abs.floor

    count += full_rotations

    if ((position + total_rotations) % @dial_length == 0 && count > 0) 
      count -= 1
    end

    if full_rotations.abs == 0 && (position + total_rotations < 0)
      count += 1
    end

    count
  end

  def solve_secret_code_2
    answer = 0
    dial = create_dial

    @rotations.each do |rotation|
      if rotation[0] == 'L'
        answer += count_points_at_zero(dial[0], rotation[1..-1].to_i)
        dial.rotate!(rotation[1..-1].to_i)
      else
        answer += count_points_at_zero(dial[0], -rotation[1..-1].to_i)
        dial.rotate!(-rotation[1..-1].to_i)
      end

      dial[0].zero? && answer += 1
    end

    answer
  end
end

rotations = File.read('rotations.txt').split("\n")
secret_entrance = SecretEntranceOpener.new(rotations)

puts secret_entrance.solve_secret_code_2