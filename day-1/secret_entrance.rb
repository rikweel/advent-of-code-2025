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

  def solve_secret_code
    answer = 0
    dial = create_dial

    @rotations.each do |rotation|
      if rotation[0] == 'L'
        dial.rotate!(rotation[1..-1].to_i)
      else
        dial.rotate!(-rotation[1..-1].to_i)
      end

      dial[0] == 0 && answer += 1
    end

    answer
  end
end

rotations = File.read('rotations.txt').split("\n")
secret_entrance = SecretEntranceOpener.new(rotations)

puts secret_entrance.solve_secret_code