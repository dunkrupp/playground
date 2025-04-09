# frozen_string_literal: true

# Allows simple requests to be made
module Requestable
  def get(uri:)
    Net::HTTP.get(uri)
  end

  def post(uri:, data:, headers: nil)
    Net::HTTP.post(uri, data, headers:)
  end

  def json(string = "")
    JSON.parse(string)
  end
end
