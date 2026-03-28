require "mcp"
require "json"
require_relative "lib/elgato_key_light"

class ElgatoKeyLightControlTool < MCP::Tool
  tool_name "elgato_key_light_control_tool"
  description "Controls the Elgato Key Light. Turn it on/off, set brightness (0-100) and color temperature (2900-7000 Kelvin)."

  input_schema(
    properties: {
      on: { type: "integer" },
      brightness: { type: "integer" },
      temperature: { type: "integer" },
    }
  )

  output_schema(
    properties: {
      type: { type: "string" },
      text: { type: "string" },
    }
  )

  class << self
    def call(on:, brightness:, temperature:)
      result = ElgatoKeyLight.set_light_state(on: on, brightness: brightness, temperature: temperature)

      MCP::Tool::Response.new([{
        type: "text",
        text: "Light state set with response code: #{result}",
      }])
    rescue => e
      MCP::Tool::Response.new([{ type: "text", text: JSON.generate({ error: e.message }) }])
    end
  end
end

class ElgatoKeyLightStatusTool < MCP::Tool
  tool_name "elgato_key_light_status_tool"
  description "Returns the current state of the Elgato Key Light: whether it is on, brightness level, and color temperature."

  input_schema(properties: {})

  output_schema(
    properties: {
      type: { type: "string" },
      text: { type: "string" },
    }
  )

  class << self
    def call
      result = ElgatoKeyLight.get_light_state

      MCP::Tool::Response.new([{
        type: "text",
        text: result,
      }])
    rescue => e
      MCP::Tool::Response.new([{ type: "text", text: JSON.generate({ error: e.message }) }])
    end
  end
end

# Set up the server
server = MCP::Server.new(
  name: "elgato_key_light_control_server",
  tools: [ElgatoKeyLightControlTool, ElgatoKeyLightStatusTool],
)

transport = MCP::Server::Transports::StdioTransport.new(server)
transport.open
