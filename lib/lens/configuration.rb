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

    def default_port
      80
    end

    def default_host
      'lens.coub.com'
    end

    def default_protocol
      'https'
    end
  end
end
