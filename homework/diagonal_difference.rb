# frozen_string_literal: true

require 'json'
require 'stringio'

# @param [Array<Array>] matrix
# @return [Integer]
def diagonal_difference(matrix)
  return 0 if matrix.empty?

  length = matrix.length
  left_to_right_diagonal = 0
  right_to_left_diagonal = 0

  matrix.each_with_index do |row, index|
    left_to_right_diagonal += row[index]
    right_to_left_diagonal += row[length - index - 1]
  end

  left_to_right_diagonal - right_to_left_diagonal
end

matrix = [
  [11,  2,   4],
  [4,   5,   6],
  [10,  8, -12]
]
# 11 + 5 + (-12) ->   4
#  4 + 5 + 10    ->  19
# ---------------------
#  4 - 19        -> -15
result = diagonal_difference(matrix)

puts "Diagonal difference is: #{result}"
