require "lens/version"
require "lens/configuration"
require "lens/gzip_util"
require "lens/compression"
require "lens/sender"
require "lens/event_formatter"
require "lens/gc"
require "lens/trace"

module Lens
  if defined?(Rails)
    require "lens/railtie"
  end
end
