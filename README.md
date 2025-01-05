# WS Chat

A brief WebSocket chat app, with a server component and a client component. The client is in CLI format.

## Install and run

### Server component

Get the server component up and running with docker

```bash
  docker-compose build
  docker-compose up
```

### Client component

Get the component running with ruby and bundle.

You need ruby 3.2.2 and bundler installed.

```bash
bundle install
```

Run the client

```bash
bundle exec ruby ./client/app.rb <name> <server_url>

# For example:
bundle exec ruby client/app.rb Antonio ws://localhost:9292
```
