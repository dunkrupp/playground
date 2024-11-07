# frozen_string_literal: true

# Linked List
#   - Node
#   - LinkedList
#     - contains Nodes that are connected to the next Node, linearly.

# a Node contains a value, exists as a chain on the list
class Node
  attr_accessor :next_node

  def initialize(value)
    @value = value
    @next_node = nil
  end

  def to_s
    "<#{self.class} value:#{@value}>"
  end
end

# a LinkedList which contains linearly chained Nodes
class LinkedList
  def initialize
    @head = nil
  end

  # Adds a value to the `head` of the list
  def add_head(value)
    node = Node.new(value)
    node.next_node = @head unless @head.nil?

    @head = node
  end

  # Adds a value to the `tail` of the list
  def add_tail(value)
    node = Node.new(value)

    if @head.nil?
      @head = node
    else
      temp = @head
      temp = temp.next_node until temp.next_node.nil?
      temp.next_node = node
    end
  end

  def delete_head
    if !@head.nil? && !@head.next_node.nil?
      new_head = @head.next_node
      @head = new_head
    elsif !@head.nil? && @head.next_node.nil?
      @head = nil
    end
  end

  def delete_tail
    return if @head.nil?

    new_tail = @head
    new_tail = new_tail.next_node until new_tail.next_node.next_node.nil?
    new_tail.next_node = nil
  end

  # Iterates over each +Node+
  def each
    return if @head.nil?

    current_node = @head
    until current_node.nil?
      yield current_node

      current_node = current_node.next_node
    end
  end

  def print
    puts '<LinkedList>'
    each { |node| puts " #{node}" }
    puts '</LinkedList>'
  end
end

linked_list = LinkedList.new

linked_list.add_head(3)
linked_list.add_head(1)
linked_list.add_head(5)
linked_list.add_head(2)
linked_list.print
# <LinkedList>
#   <Node value:2>
#   <Node value:5>
#   <Node value:1>
#   <Node value:3>
# </LinkedList>

linked_list.delete_head
linked_list.print
# <LinkedList>
#  <Node value:5>
#  <Node value:1>
#  <Node value:3>
# </LinkedList>

linked_list.delete_tail
linked_list.add_tail(8)
linked_list.print
# <LinkedList>
#   <Node value:5>
#   <Node value:1>
#   <Node value:8>
# </LinkedList>
