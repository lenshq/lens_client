require "lens/core"

module Lens
  def self.configure
    yield(config)
    config
  end

  def self.config
    @config ||= Config.new
  end
end
