# frozen_string_literal: true

class Command
  def initialize(name: nil)
    @name = name
    @shortcuts = {}
  end

  def shortcut(*shortcuts, &block)
    shortcuts.each do |shortcut|
      @shortcuts[shortcut] = block
    end
  end
end
