# frozen_string_literal: true

# Write a program that outputs the string representation of numbers
# from 1 to n. But for multiples of three it should output “Fizz”
# instead of the number and for the multiples of five output “Buzz”.
# For numbers which are multiples of both three and five output
# “FizzBuzz”.

def replace_multiples(number)
  multiple_of_three = (number % 3).zero?
  multiple_of_five = (number % 5).zero?

  if multiple_of_three && multiple_of_five
    'FizzBuzz'
  elsif multiple_of_three
    'Fizz'
  elsif multiple_of_five
    'Buzz'
  else
    number
  end
end

def fizz_buzz(n)
  range = (1..n)

  result = range.map { |number| replace_multiples(number) }
  result.join('')
end

puts fizz_buzz(15) # 12Fizz4BuzzFizz78FizzBuzz11Fizz1314FizzBuzz
