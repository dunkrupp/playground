# frozen_string_literal: true

require_relative 'message'

class Client
  attr_reader :id, :ip, :hostname, :port, :socket

  def initialize(socket)
    @socket = socket
    @ip = @socket.peeraddr[2]
    @port = @socket.peeraddr[1]
    #@hostname = Addrinfo.getaddrinfo(@socket.peeraddr[3])[0]
  end

  def close
    socket.close
  end

  def read
    socket.gets(Message::DEFAULT_INPUT_SIZE).strip
  end

  def write(message)
    socket.puts(message)
  end
end
