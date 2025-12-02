input = File.read('day-2/input.txt').split(',').map { |range| range.split('-').map(&:to_i) }

def find_invalid_ids(input)
  answer = 0
  for range in input
    all_numbers = (range[0]..range[1]).to_a
    for number in all_numbers
      digits = number.digits
      # TODO: add invalid numbers, not all numers
      answer += number unless digits.uniq.length == digits.length
    end
  end

  answer
end

puts find_invalid_ids(input)
