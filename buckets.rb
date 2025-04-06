# frozen_string_literal: true

require 'csv'

# Encapsulates any records that don't find a home (if there are any)
default_bucket = Bucket.new(title: 'Default')

# Use a Set to enforce uniqueness of buckets
buckets = Set[]
buckets.add(default_bucket)

module Buckets
  Bucket = Struct.new(:title, :items) do
    def initialize(title:)
      self.title = title
      self.items = Set[]
    end

    def add(item)
      item = Item.from(item) unless item.is_a?(Item)

      @items << item
    end

    def count
      @items.count
    end
  end

  Item = Struct.new(:title, :total)
end

# Parse CSV items into buckets.
CSV.open('test.csv', 'r') do |csv|
  bucket = nil

  csv.each do |row|
    case row.length
    when 1
      bucket = ::Buckets::Bucket.new(title: row[0])
      buckets.add(bucket)
    when 2
      bucket.add(
        Item.new(
          title: row[0],
          total: Float(row[1]).round(2)
        )
      )
    else
      puts " -- ERROR -- #{row} was unable to be processed"
    end

    pp bucket
  end

  pp bucket
end

pp buckets