require 'pry'
require 'json'

module Lens
  class Sender
    NOTICES_URI = 'api/v1/events'.freeze

    attr_reader :app_key, :protocol, :host, :port

    def initialize(options = nil)
      raise ArgumentError unless options.is_a? Configuration

      @app_key = options.app_key
      @protocol = options.protocol
      @protocol = options.protocol
      @host = options.host
      @port = options.port
    end

    def send_to_lens(data)
      send_request(data, url.path)
    end

    private

    def send_request(data, path)
      http_connection.post(path, data, http_headers)
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
