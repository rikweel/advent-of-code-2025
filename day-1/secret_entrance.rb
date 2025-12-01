rotations = File.read('rotations.txt').split("\n")
dial = Array.new(100) { |i| i }
dial.rotate!(50)

@answer = 0
rotations.each do |rotation|
  if rotation[0] == 'L'
    dial.rotate!(rotation[1..-1].to_i)
  else
    dial.rotate!(-rotation[1..-1].to_i)
  end

  dial[0] == 0 && @answer += 1
end

puts @answer
