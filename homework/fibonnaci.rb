# frozen_string_literal: true

# @param [Integer] number
# @return [Array<Integer>]
def fibonnaci(number)
  return [0] if number.zero?
  return [0, 1] if number == 1

  sequence = fibonnaci(number - 1)
  sequence << sequence[-1] + sequence[-2]
end

input = Integer(ARGF.argv[0]) || 5

# @type [Array] result
result = fibonnaci(input)

puts "The result is: #{result.sum}"
