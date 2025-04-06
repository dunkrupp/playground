# frozen_string_literal: true

class ClientPool
  def initialize
    @clients = {}
  end

  # Adds a client to the client pool, using an symbol `id` as the key.
  #
  # Example:
  #   pool = new ClientPool
  #   pool.add(TCPSocket.new(...))
  #
  # @param [Symbol]     id
  # @param [Client]  client
  # @return [ClientPool]
  def add(id, client)
    @clients[id] = client
    self
  end

  # @param [Symbol] id
  def excluding(id)
    @clients.except(id)
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
    @clients.delete(id)
    self
  end
end
