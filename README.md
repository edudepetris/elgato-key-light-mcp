# Elgato Key Light MCP Server

A Ruby MCP server to control your Elgato Key Light via stdio.

## Requirements

- Ruby 4.0.2
- Bundler
- Elgato Key Light on your local network

## Setup

```bash
bundle install
```

## Run

```bash
bundle exec ruby stdio_server.rb
```

Set the light host if different from the default (`192.168.100.13:9123`):

```bash
ELGATO_LIGHT_HOST=192.168.1.50:9123 bundle exec ruby stdio_server.rb
```

## Docker

```bash
docker build -t elgato-mcp .
docker run -i --rm elgato-mcp
```

> **macOS limitation:** Docker Desktop on Mac does not support `--network host`, so containers cannot reach LAN devices like the Elgato Key Light. On macOS, skip Docker and connect the MCP server directly (see below).

## Add to Claude Desktop

On macOS, run the server directly with Ruby. Edit `~/Library/Application Support/Claude/claude_desktop_config.json`:

```json
{
  "mcpServers": {
    "elgato-key-light": {
      "command": "/path/to/bundle",
      "args": ["exec", "ruby", "/path/to/ruby-mcp-el-gato/stdio_server.rb"]
    }
  }
}
```

Find your `bundle` path with `which bundle`.

## Test via JSON-RPC

Control the light:

```json
{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"elgato_key_light_control_tool","arguments":{"on":1,"brightness":50,"temperature":3000}}}
```

Get current state:

```json
{"jsonrpc":"2.0","id":1,"method":"tools/call","params":{"name":"elgato_key_light_status_tool","arguments":{}}}
```