# frozen_string_literal: true

require 'faye/websocket'
require 'json'

App = lambda do |env|
  @clients ||= []

  if Faye::WebSocket.websocket?(env)
    ws = Faye::WebSocket.new(env)

    ws.on :open do |_event|
      puts 'Client connected'
      @clients << ws
    end

    ws.on :message do |event|
      puts "Received message: #{event.data}"

      @clients.each do |client|
        next if client == ws

        client.send(event.data)
      end
    end

    ws.on :close do |event|
      p [:close, event.code, event.reason]

      @clients.each do |client|
        next if client == ws

        data = { name: 'System', message: 'Someone has disconnected' }

        client.send data.to_json
      end

      @clients.delete ws
      ws = nil
    end

    # Return async Rack response
    ws.rack_response
  else
    # Normal HTTP request
    [200, { 'Content-Type' => 'text/plain' }, ['Hello']]
  end
end
