# frozen_string_literal: true

# lifo (last-in, first-out)
class Stack
  def initialize(stack = [])
    @stack = stack
  end

  # Adds an item to the top of the stack.
  def push(item)
    @stack.push(item)
  end

  # Removes and returns the item at the top of the stack.
  def pop
    @stack.pop
  end

  # Returns the item at the top of the stack.
  def peek
    @stack[top]
  end

  def empty?
    @stack.empty?
  end

  def size
    @stack.length
  end

  private

  def top
    @stack.length - 1
  end
end
