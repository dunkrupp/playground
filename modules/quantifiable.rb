# frozen_string_literal: true

module Quantifiable
  class InvalidQuantityError < ArgumentError; end

  def self.included(base)
    base.attr_reader :quantity
  end

  def quantity=(value)
    if value.nil?
      @quantity = 0
    else
      begin
        @quantity = Integer(value)
      rescue ArgumentError, TypeError
        raise InvalidQuantityError, "Cannot convert '#{value.inspect}' to a valid quantity (Integer)"
      end
    end
  end
end
