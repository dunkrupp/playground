# frozen_string_literal: true

require 'logger'
require 'socket'

require_relative 'client'
require_relative 'client_pool'

class Server
  attr_reader :host, :port, :server

  COMMANDS = {
    quit: 'q',
    send: 's'
  }.freeze

  module Messages
    GOODBYE = "Goodbye!\r\n"
    INPUT_ERROR = "OOPS! That was not a command.\r\n"
    WELCOME = "Welcome to the server!\r\n"
  end

  DEFAULT_HOST = 'localhost'
  DEFAULT_PORT = 8080

  def initialize(host: DEFAULT_HOST, port: DEFAULT_PORT)
    @logger = ::Logger.new($stdout)
    @host = host
    @pool = ::ClientPool.new
    @port = port
    @server = ::TCPServer.new(host, port)
  end

  def listen
    server_listening

    loop do
      @pool << Thread.new(Client.new(@server.accept)) do |client|
        puts '*' * 20
        puts client
        puts client.class.name
        new_client_connection_established(client)

        client.write(Messages::WELCOME)
        client.puts(prompt)
        command = ''

        while command != COMMANDS[:quit]
          # client.receive
          command, *args = client.gets(4096).strip.split

          case command
          when COMMANDS[:quit]
            # client.close
            client.puts(Messages::GOODBYE)
            client.close
            @logger.add(::Logger::INFO, " - [DEBUG] connection closed.\n")
            break
          when COMMANDS[:send]
            # client.write
            message = args.join(' ')
            client.puts("->  #{message}")
            @logger.add(::Logger::INFO, message)
            break
          else
            client.puts("<- #{Messages::INPUT_ERROR} ")
          end
        end
      end
    end
  end

  def prompt
    <<~PROMPT
      ===============
          Commands
      ===============
        (s)end - sends a message to the server'
        (q)uit - exits the server'

      ===============
    PROMPT
  end

  private

  def new_client_connection_established(client)
    @logger.add(::Logger::INFO, "*** Connection established from #{client.ip}")
  end

  def server_listening
    @logger.add(::Logger::INFO, "*** Server listening on #{host}:#{port}")
  end
end

Server.new.listen
