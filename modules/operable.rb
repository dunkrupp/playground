# frozen_string_literal: true

#  Adds parameters
module Operable
  def self.included(klass)
    klass.extend(ClassMethods)
  end

  # Class method definitions
  module ClassMethods
    # @api public
    def self.param(*names, opts)
      names.each do |name|
        define_method(name) do
          @params[name]
        end
        define_method("#{name}=") do |value|
          @params[name] = value
        end
      end
    end

    def params
      @params ||= {}
    end
  end

  def initialize(*params)
    super

    self.class.params.each_key do |name|
      instance_variable_set(param, params[name])
    end
  end
end
