input = File.read('day-3/input.txt').split("\n")

def find_max_joltage_per_bank(bank, n)
  digits = bank.each_char.map(&:to_i)
  max_joltage = 0

  (0..digits.length - n).each do |first_index|
    selected = [digits[first_index]]
    current_index = first_index

    (n - 1).times do
      remaining_needed = n - selected.length
      remaining_start = current_index + 1
      search_end = digits.length - remaining_needed

      break if search_end < remaining_start

      segment = digits[remaining_start..search_end]
      break if segment.nil? || segment.empty?

      next_digit = segment.max
      next_index = segment.index(next_digit) + remaining_start

      selected << next_digit
      current_index = next_index
    end

    if selected.length == n
      joltage = selected.join.to_i
      max_joltage = [max_joltage, joltage].max
    end
  end

  max_joltage
end

def find_max_total_joltage(input)
  total_joltage = 0

  input.each do |bank|
    max_joltage = find_max_joltage_per_bank(bank, 12)
    total_joltage += max_joltage
  end

  total_joltage
end

puts find_max_total_joltage(input)