# frozen_string_literal: true

class ClientPool
  def initialize
    @connections = {}
  end

  # Adds a client to the client pool, using an symbol `id` as the key.
  #
  # Example:
  #   pool = new ClientPool
  #   pool.add(TCPSocket.new(...))
  #
  # @param [Symbol]     id
  # @param [TCPSocket]  connection
  # @return [ClientPool]
  def add(id, connection)
    @connections[id] = connection
    self
  end

  # @param [Symbol] id
  def excluding(id)
    @connections.except(id)
  end

  # Adds a client to the client pool, using an symbol `id` as the key.
  #
  # Example:
  #   pool = new ClientPool
  #   pool.remove(:cindy)
  #
  # @param [Symbol] id
  # @return [ClientPool]
  def remove(id)
    @connections.delete(id)
    self
  end
end
