raise 'WTF!?!?! Where is Rails man?' unless defined?(Rails)

require 'lens/core'
require 'lens/railtie'

module Lens
  HEADERS = {
    'Content-type' => 'application/json',
    'Content-Encoding' => 'deflate',
    'Accept' => 'text/json, application/json',
    'User-Agent' => "LENS-Ruby client #{VERSION}; #{RUBY_VERSION}; #{RUBY_PLATFORM}"
  }.freeze

  class << self
    attr_accessor :sender
    attr_writer :configuration

    def configure
      yield(configuration)

      Lens.start

      self.sender = Sender.new(configuration)
      self.sender
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def start
      Worker.start(configuration)
    end

    def stop
      Worker.stop
    end
  end
end
