input = File.read('day-3/input.txt').split("\n")

def find_max_joltage_per_bank(bank)
  bank_arr = bank.each_char.map(&:to_i)
  first_num = bank_arr[0]
  second_num = bank_arr[1]

  bank_arr[2..-1].each do |number|
    if number > first_num 
      first_num = number
    elsif number > second_num
      second_num = number
    end

    first_num == 9 && second_num == 9 && break
  end

  [first_num, second_num].join().to_i
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