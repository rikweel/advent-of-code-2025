input = File.read('day-2/input.txt').split(',').map { |range| range.split('-').map(&:to_i) }

def repeated_sequence?(arr)
  return false if arr.empty? || arr.length.odd?
  
  mid = arr.length / 2
  arr[0...mid] == arr[mid..-1]
end

def repeated_sequence_two?(arr)
  return false if arr.empty?
  
  (1..arr.length/2).each do |seq_len|
    next unless arr.length % seq_len == 0
    
    sequence = arr[0...seq_len]
    return true if arr.each_slice(seq_len).all? { |chunk| chunk == sequence }
  end
  
  false
end

def find_invalid_ids(input)
  answer = 0
  for range in input
    all_numbers = (range[0]..range[1]).to_a
    for number in all_numbers
      repeated_sequence_two?(number.digits.reverse) && answer += number
    end
  end

  answer
end

puts find_invalid_ids(input)
