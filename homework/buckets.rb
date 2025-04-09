# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require 'csv'
require 'logger'

require_relative '../modules/monetary'
require_relative '../modules/quantifiable'

###################################################################
#                          Definitions                            #
###################################################################

# For creating and manipulating +Buckets+ and their +Items+.
# [Struct] Bucket
# [Struct] Item
module Buckets
  class Bucket
    include Enumerable

    attr_reader :name, :items

    def initialize(name:)
      @name = name
      @items = []
    end

    def add(item)
      item = Item.from(item) unless item.is_a?(Item)

      items.push(item)
    end

    def to_s
      " -- Bucket #{name} -- \n" \
        " --- Items: #{items.count} \n" \
        " --- Total: #{items.map(&:amount).inject(:+)} \n"
    end
  end

  class Item
    include Monetary
    include Quantifiable

    def initialize(amount:, name:, quantity:)
      @amount = amount
      @name = name
      @quantity = quantity || 0
    end
  end
end

###################################################################
#                              Logic                              #
###################################################################
logger = Logger.new(STDOUT)

# Encapsulates any records that don't find a home (if there are any)
error_bucket = Buckets::Bucket.new(name: :default)

# Use a Set to enforce uniqueness of buckets
buckets = {}
buckets[:errors] = error_bucket

# Parse CSV items into buckets.
CSV.open('test.csv', 'r') do |csv|
  bucket = nil

  csv.each do |row|
    case row.length
    when 1
      begin
        name = row[0]
        bucket = Buckets::Bucket.new(name:)
        buckets[name.to_sym] = bucket

        logger.info(" -- New Bucket Created -> #{bucket.name} -- ")
      end
    when 2
      begin
        name, amount = row
        bucket.add(Buckets::Item.new(amount:, name:, quantity: 1))
      rescue ArgumentError, TypeError => e
        logger.warn("Skipping invalid item row: #{row}. Error: #{e.message}")
      end
    else
      next if row.empty?

      logger.warn("Skipping row with unexpected number of columns: #{row}")
    end
  end
end

buckets.map { |bucket| puts bucket }
