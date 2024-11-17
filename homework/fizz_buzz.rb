# frozen_string_literal: true

# Write a program that outputs the string representation of numbers
# from 1 to n. But for multiples of three it should output “Fizz”
# instead of the number and for the multiples of five output “Buzz”.
# For numbers which are multiples of both three and five output
# “FizzBuzz”.

def fizz_buzz(n)
  (1..n).map do |number|
    result = []
    result << 'Fizz' if (number % 3).zero?
    result << 'Buzz' if (number % 5).zero?
    result << number.to_s if result.empty?
    result.join('')
  end.join('')
end

puts fizz_buzz(15) # 12Fizz4BuzzFizz78FizzBuzz11Fizz1314FizzBuzz
