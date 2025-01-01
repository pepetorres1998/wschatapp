# frozen_string_literal: true

require 'faye/websocket'
require 'eventmachine'
require 'json'

EM.run do
  ws = Faye::WebSocket::Client.new('ws://0.0.0.0:9292')

  ws.on :open do |_event|
    p [:open]
    data = { name: 'Jose', message: 'Hello, world!' }
    ws.send(data.to_json)
  end

  ws.on :message do |event|
    data = JSON.parse(event.data)
    puts "#{data['name']}: #{data['message']}"
  end

  ws.on :close do |event|
    p [:close, event.code, event.reason]
    ws = nil
  end
end
