require 'rails'

module Lens
  class Railtie < Rails::Railtie
    ActiveSupport::Notifications.subscribe(/.*/) do |name, start, finish, id, payload|
      event = Event.new(
        name: name,
        started: start,
        finished: finish,
        transaction_id: id,
        payload: payload
      )

      Trace.process(event)
    end
  end
end
