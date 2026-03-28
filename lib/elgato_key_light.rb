# ➜ curl -X PUT "http://192.168.100.13:9123/elgato/lights" -H "Content-Type: application/json" -d '{"lights":[{"on":0,"brightness":100}]}'

require 'net/http'
require 'uri'
require 'json'

module ElgatoKeyLight
  ON = 1.freeze # Light on
  MAX_BRIGHTNESS = 100.freeze
  MIN_BRIGHTNESS = 3.freeze
  MAX_TEMPERATURE = 143.freeze # 7000K
  MIN_TEMPERATURE = 344.freeze # 2900K

  def self.set_light_state(on: ON, brightness: 75, temperature: MIN_TEMPERATURE)
    uri = URI('http://192.168.100.13:9123/elgato/lights')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Put.new(uri.path, 'Content-Type': 'application/json')

    body = { "lights": [ {"on":on,"brightness":brightness,"temperature":temperature} ] }.to_json
    request.body = body

    response = http.request(request)
    response.code
  end

  def self.get_light_state
    uri = URI('http://192.168.100.13:9123/elgato/lights')
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.path, 'Content-Type': 'application/json')

    response = http.request(request)
    JSON.parse(response.body)
  end
end