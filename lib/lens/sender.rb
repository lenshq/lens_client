require 'pry'

module Lens
  class Sender
    NOTICES_URI = 'api/v1/record'
    HTTP_ERRORS = [Timeout::Error,
                   Errno::EINVAL,
                   Errno::ECONNRESET,
                   EOFError,
                   Net::HTTPBadResponse,
                   Net::HTTPHeaderSyntaxError,
                   Net::ProtocolError,
                   Errno::ECONNREFUSED].freeze

    def initialize(options = {})
      [ :app_id,
        :secret,
        :protocol,
        :host,
        :port
      ].each do |option|
        instance_variable_set("@#{option}", options.send(option))
      end
    end

    def send_to_lens(data)
      response = send_request(url.path, data, {'X-API-Key' => secret})
    end

    attr_reader :app_id,
      :secret,
      :protocol,
      :host,
      :port

  private

    def http_connection
      setup_http_connection
    end

    def setup_http_connection
      Net::HTTP.new(url.host, url.port)
    rescue => e
      log(:error, "[Lens::Sender#setup_http_connection] Failure initializing the HTTP connection.\nError: #{e.class} - #{e.message}\nBacktrace:\n#{e.backtrace.join("\n\t")}")
      raise e
    end

    def send_request(path, data, headers = {})
      http_connection.post(path, data, http_headers(headers))
    rescue *HTTP_ERRORS => e
      raise e
      nil
    end

    def http_headers(headers=nil)
      {}.tap do |hash|
        hash.merge!(HEADERS)
        hash.merge!({'X-API-Key' => secret})
        hash.merge!(headers) if headers
      end
    end

    def url
      URI.parse("#{protocol}://#{host}:#{port}").merge(NOTICES_URI)
    end
  end
end
