input = File.read("day-5/input.txt").split("\n\n")

fresh_ids_ranges = input[0].split("\n").map do |line|
  line = line.split("-").map(&:to_i)
  line = line[0]..line[1]
end

available_ingredient_ids = input[1].split("\n").map(&:to_i)
# puts available_ingredient_ids

def find_fresh_ingredient_ids(fresh_ids_ranges, available_ingredient_ids)
  fresh_products = []
  available_ingredient_ids.each do |id|
    fresh_ids_ranges.each do |range|
      if range.include?(id)
        fresh_products << id
        break
      end
    end
  end
  fresh_products
end

puts find_fresh_ingredient_ids(fresh_ids_ranges, available_ingredient_ids).length

def combine_fresh_ids_ranges(fresh_ids_ranges)
  combined_ranges = []
  fresh_ids_ranges.sort_by!(&:begin)

  fresh_ids_ranges.each do |current_range|
    if combined_ranges.empty? || combined_ranges.last.end < current_range.begin - 1
      combined_ranges << current_range
    else
      last = combined_ranges.pop
      combined_ranges << (last.begin..[last.end, current_range.end].max)
    end
  end

  combined_ranges
end

def count_total_ids_in_ranges(ranges)
  total = 0
  ranges.each do |range|
    total += range.end - range.begin + 1
  end
  total
end

puts count_total_ids_in_ranges(combine_fresh_ids_ranges(fresh_ids_ranges))
