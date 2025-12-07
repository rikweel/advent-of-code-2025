input = File.read('day-6/input.txt')

def format_input_to_problems(input)
  lines = input.split("\n").map do |line|
    line.split(/\s+/)
  end

  lines[0].zip(*lines[1..-1])
end

def format_input_to_right_to_left_problems(input)
  lines = input.split("\n").map.to_a

  problems = []

  # use the line with operators to find the max length of each column, by counting the whitespaces minus one to the next operator
  operators = lines[-1].scan(/[+*]\s*/)
  operators.each_with_index do |item, index|
    problems << {index: index, operator: item[0], length: item.length}
  end

  lines[...-1].each do |line|
    # take the characters from each line based on the lengths found above
    problems.each do |problem|
      segment = line[0, problem[:length]]
      problem[:values] ||= []
      problem[:values] << segment
      line = line[problem[:length]..-1]
    end
  end

  problems.map! do |problem|
    problem[:values].map!(&:reverse)
    # take each char at index n from each item and place them after each other. skip whitespace. turn the chars into integers
    # then add the operator at the end
    # e.g. [" 12", "834", " 956"] with operator "+" becomes [89, 135, 246, "+"]
    values = []
    max_length = problem[:values].map(&:length).max
    (0...max_length).each do |i|
      chars = problem[:values].map { |v| v[i] || ' ' }
      number_str = chars.join.strip
      values << number_str.to_i unless number_str.empty?
    end
    values << problem[:operator]
    values
  end

  problems
end

def solve_problems(problems)
  total = 0
  problems.each do |problem|
    operator = problem[-1]
    total += problem[...-1].map(&:to_i).reduce(operator)
  end

  total
end

# problems = format_input_to_problems(input)
problems = format_input_to_right_to_left_problems(input)
puts solve_problems(problems)