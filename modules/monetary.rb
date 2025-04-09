# frozen_string_literal: true

module Monetary
  class InvalidAmountError < ArgumentError; end

  def self.included(base)
    base.attr_reader :amount
  end

  def amount=(value)
    if value.nil?
      @amount = nil
    else
      begin
        @amount = value.to_d
      rescue ArgumentError, TypeError
        raise InvalidAmountError, "Cannot convert '#{value.inspect}' to a valid amount (BigDecimal)"
      end
    end
  end

  def to_cents
    return 0 if amount.nil?

    (amount * 100).to_i
  end

  def to_dollars
    return "0.00" if amount.nil?

    sprintf("%.2f", amount)
  end
end
