require 'pry'
require 'json'

module Lens
  class Sender
    NOTICES_URI = 'api/v1/events'.freeze
    HEADERS = {
      'Content-type' => 'application/json',
      'Content-Encoding' => 'deflate',
      'Accept' => 'text/json, application/json',
      'User-Agent' => "LENS-Ruby client #{VERSION}; #{RUBY_VERSION}; #{RUBY_PLATFORM}"
    }.freeze

    attr_reader :app_key, :protocol, :host, :port, :compressor

    def initialize(options = nil)
      raise ArgumentError unless options.is_a? Configuration

      @app_key = options.app_key
      @protocol = options.protocol
      @host = options.host
      @port = options.port
      @compressor = options.compressor
    end

    def send_to_lens(data)
      send_request(url.path, compressor.compress(data), compressor.headers)
    end

    private

    def send_request(path, data, additional_headers = {})
      headers = http_headers.merge additional_headers
      http_connection.post(path, data, headers)
    end

    def http_headers
      HEADERS.merge('X-Auth-Token' => app_key)
    end

    def url
      URI.parse("#{protocol}://#{host}:#{port}").merge(NOTICES_URI)
    end

    def http_connection
      Net::HTTP.new(url.host, url.port)
    end
  end
end
