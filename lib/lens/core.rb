require "lens/version"

module Lens
  if defined?(Rails)
    require "lens/railtie"
  end
end
