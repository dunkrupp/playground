# frozen_string_literal: true

# Adds a class and instance methods for defining a call action.
module Callable
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  # Class method definitions
  module ClassMethods
    # Class-based definition
    # @api public
    def call(&)
      raise NotImplementedError, "Empty call block." unless block_given?

      yield
    end
  end

  # Instance-based definition
  # @api public
  def call
    raise NotImplementedError, "Empty call block." unless block_given?

    yield
  end
end
