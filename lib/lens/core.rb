require "lens/version"
require "lens/configuration"
require "lens/sender"

module Lens
  if defined?(Rails)
    require "lens/railtie"
  end
end
