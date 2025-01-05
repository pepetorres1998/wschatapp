# frozen_string_literal: true

require 'faye/websocket'
require 'eventmachine'
require 'json'

class ChatClient
  attr_reader :connected, :server_url, :name

  def initialize(server_url, name)
    @server_url = server_url
    @name = name
    @ws = nil
    @connected = false
  end

  def connect
    EM.run do
      @ws = Faye::WebSocket::Client.new(server_url)

      @ws.on :open do |_event|
        puts 'Connected to the server!'
        @connected = true
        send_message('System', "#{name} has joined the chat.")
      end

      @ws.on :message do |event|
        data = JSON.parse(event.data)
        puts "[#{data['name']}] #{data['message']}"
        print '> '
      end

      @ws.on :close do |event|
        puts "Connection closed. Code: #{event.code} Reason: #{event.reason}"
        @connected = false
        @ws = nil
        EM.stop
      end
    end
  end

  def send_message(name, message)
    return unless @connected

    data = { name: name, message: message }
    @ws.send(data.to_json)
  end

  def disconnect
    return unless @connected

    send_message('System', "#{name} has left the chat.")
    @ws.close
  end
end
