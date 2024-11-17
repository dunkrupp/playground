# frozen_string_literal: true

# homework: double_trouble
#   input: list
#   output: list
#   constraints: array<integer> 1..1000
#   sorted: asc

input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0, 8]

double = lambda do |n|
  n * 2
end

puts input.map(&double).sort
