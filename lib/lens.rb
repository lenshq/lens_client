require "lens/core"
require 'pry'

module Lens
  HEADERS = {
    'Content-type' => 'application/json',
    'Content-Encoding' => 'deflate',
    'Accept'       => 'text/json, application/json',
    'User-Agent'   => "LENS-Ruby #{VERSION}; #{RUBY_VERSION}; #{RUBY_PLATFORM}"
  }.freeze

  class << self
    attr_accessor :sender
    attr_writer :configuration

    def configure
      yield(configuration)

      self.sender = Sender.new(configuration)
      self.sender
    end

    def configuration
      @configuration ||= Configuration.new
    end
  end
end
