require 'rails'

module Lens
  class Railtie < Rails::Railtie
    ActiveSupport::Notifications.subscribe(/.*/) do |*args|
      Trace.process(build_event args)
    end

    def build_event(args)
      Event.new(
        name: args[0],
        started: args[1],
        finished: args[2],
        transaction_id: args[3],
        payload: args[4]
      )
    end
  end
end
