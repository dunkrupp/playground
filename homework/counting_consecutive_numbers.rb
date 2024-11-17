# frozen_string_literal: true

# count iterations of numbers in a row, and prefix with count.
#   - 12          -> 1112
#   - 11122112    -> 31222112
def count_and_prefix(input_string)
  output_string = ''
  current_char = input_string[0]
  count = 1

  input_string[1..].each_char do |char|
    if char == current_char
      count += 1
    else
      output_string += count.to_s + current_char
      current_char = char
      count = 1
    end
  end

  output_string += count.to_s + current_char
  output_string
end

# Example usage
puts count_and_prefix('12')          # Output: 1112
puts count_and_prefix('11122112')    # Output: 31222112
