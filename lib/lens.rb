# encoding: utf-8

raise 'WTF!?!?! Where is Rails man? ❨╯°□°❩╯︵┻━┻' unless defined?(Rails)

require 'lens/core'
require 'lens/railtie'
require 'lens_memprof'

module Lens
  class << self
    attr_accessor :sender
    attr_writer :configuration

    def configure
      yield(configuration)

      self.sender = Sender.new(configuration)
      self
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def start
      raise ConfigurationError, 'application key required' unless configuration.app_key

      Worker.start(configuration)
    end

    def stop
      Worker.stop
    end
  end
end
