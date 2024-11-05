# frozen_string_literal: true

def print_step(length)
  puts '#' * length
end

def staircase(steps: 5)
  (1..steps).each { |i| print_step(i) }
end

steps = Integer(ARGF.argv[0])

staircase(steps:)
