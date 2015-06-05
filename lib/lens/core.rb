require "lens/version"
require "lens/configuration"
require "lens/sender"
require "lens/event_formatter"
require "lens/trace"

module Lens
  if defined?(Rails)
    require "lens/railtie"
  end
end
