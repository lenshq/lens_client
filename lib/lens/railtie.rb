require 'rails'

module Lens
  class Railtie < Rails::Railtie
    ActiveSupport::Notifications.subscribe(/.*/) do |*args|
      Trace.process(*args)
    end
  end
end
