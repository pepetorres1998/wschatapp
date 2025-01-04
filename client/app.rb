# frozen_string_literal: true

require_relative './chat_cli'

if ARGV.length != 2
  puts 'Usage: ruby app.rb <name> <server_url>'
  exit 1
end

name = ARGV[0]
server_url = ARGV[1]

chat_cli = ChatCLI.new(name, server_url)
chat_cli.start
