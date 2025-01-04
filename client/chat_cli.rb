# fronzen_string_literal: true

require_relative './chat_client'

class ChatCLI
  def initialize(name, server_url)
    @name = name
    @client = ChatClient.new(server_url, name)
  end

  def start
    Thread.new { @client.connect }

    loop do
      print '> '
      input = $stdin.gets.chomp
      break if input == '/quit'

      @client.send_message(@name, input)
    end

    @client.disconnect
    puts 'Goodbye!'
  end
end
