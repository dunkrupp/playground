# frozen_string_literal: true

class Cache
  attr_reader :cache, :expires_in, :file_path, :options

  DEFAULT_EXPIRY = 3600
  DEFAULT_FILE_PATH = 'cache.txt'

  def initialize(*options)
    @cache = load_cache || {}
    @options = options
    @expires_in = options['expires_in'] || DEFAULT_EXPIRY
    @file_path = options['file_path'] || DEFAULT_FILE_PATH
  end

  def get(key)
    @cache[key]
  end

  def set(key, value)
    @cache[key] = value
  end

  private

  def load_cache
    File.open(file_path, 'wb')
  end
end

cache = Cache.new({ file_path: '/tmp/cache.txt' })
