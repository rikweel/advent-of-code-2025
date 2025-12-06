input = File.read('day-6/input.txt')

def format_input_to_problems(input)
  lines = input.split("\n").map do |line|
    line.split(/\s+/)
  end

  lines[0].zip(*lines[1..-1])
end

def solve_problems(problems)
  total = 0
  problems.each do |problem|
    operator = problem[-1]
    total += problem[...-1].map(&:to_i).reduce(operator)
  end

  total
end

problems = format_input_to_problems(input)
puts solve_problems(problems)