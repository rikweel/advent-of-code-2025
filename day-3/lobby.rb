input = File.read('day-3/input.txt').split("\n")

def find_max_joltage_per_bank(bank)
  bank_arr = bank.each_char.map(&:to_i)

  first_number = bank_arr.max
  first_index = bank_arr.index(first_number)

  if first_index == bank_arr.length - 1
    second_number = first_number
    first_number = bank_arr[0...first_index].max
  else 
    second_number = bank_arr[(first_index + 1)..-1].max
  end

  [first_number, second_number].join.to_i
end

def find_max_total_joltage(input)
  total_joltage = 0

  input.each do |bank|
    max_joltage = find_max_joltage_per_bank(bank)
    total_joltage += max_joltage
  end

  total_joltage
end

puts find_max_total_joltage(input)