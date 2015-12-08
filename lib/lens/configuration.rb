module Lens
  class Configuration
    attr_accessor :app_key, :secret, :protocol, :host, :port, :show_memory_usage

    def protocol
      @protocol || default_protocol
    end

    def host
      @host || default_host
    end

    def port
      @port || default_port
    end

    def compressor
      default_compressor
    end

    def with_memory_usage?
      @show_memory_usage || default_memory_usage
    end

    private

    def default_port
      80
    end

    def default_host
      'lenshq.io'
    end

    def default_protocol
      'http'
    end

    def default_compressor
      Compression::LZ4
    end

    def default_memory_usage
      false
    end
  end
end
