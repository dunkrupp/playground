# frozen_string_literal: true

class Enoomerable
  def initialize(data = [])
    @data = data
  end

  def each
    return to_enum(:each) unless block_given?

    index = 0
    while index < @data.size
      yield @data[index]
      index += 1
    end
  end

  def map
    return to_enum(:map) unless block_given?

    mapped_data = []
    each { |item| mapped_data << yield(item) }
    mapped_data
  end

  def select
    return to_enum(:select) unless block_given?

    select_data = []
    each { |item| select_data << item if yield(item) }
    select_data
  end
end

enoom = Enoomerable.new([1, 2, 3])

# output [1, 2, 3]
enoom.each { |i| puts i }

# output: [1, 4, 9]
puts(enoom.map { |item| item**2 })

# output: [1, 3]
puts(enoom.select(&:odd?))
