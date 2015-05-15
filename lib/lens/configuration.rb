module Lens
  class Configuration
    attr_accessor :app_id, :secret, :protocol, :host, :port

    def protocol
      'https'
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
  end
end
