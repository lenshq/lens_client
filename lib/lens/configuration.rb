module Lens
  class Configuration
    attr_accessor :app_key, :secret, :protocol, :host, :port

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

    private

    def default_port
      80
    end

    def default_host
      'lens.staging.coub.com'
    end

    def default_protocol
      'http'
    end

    def default_compressor
      Compression::Gzip
    end
  end
end
