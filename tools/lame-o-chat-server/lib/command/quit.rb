# frozen_string_literal: true

class Quit < ::Command
  shortcut(:q, lambda(&:run))

  def run(client)
    puts 'ran quit'
    client.close
  end
end
