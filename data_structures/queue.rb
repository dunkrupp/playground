# frozen_string_literal: true

# fifo (first-in, first-out)
class Queue
  def initialize(queue = [])
    @queue = queue
  end

  # Adds an item to the end of the queue.
  def enqueue(item)
    @queue << item
  end

  # Removes and returns the item at the front of the queue.
  def dequeue
    @queue.shift
  end

  # Returns the item at the front of the queue.
  def peek
    @queue[0]
  end

  def empty?
    @queue.empty?
  end

  def size
    @queue.length
  end
end
