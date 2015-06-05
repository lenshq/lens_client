require 'rails'

module Lens
  class Railtie < Rails::Railtie
    ActiveSupport::Notifications.subscribe('start_processing.action_controller') do |name, started, finished, id, data|
      Trace.create(id)
    end

    ActiveSupport::Notifications.subscribe('sql.active_record') do |*args|
      next unless Trace.current
      event = ActiveSupport::Notifications::Event.new(*args)
      Trace.current.add(event) if event.name != 'SCHEMA'
    end

    ActiveSupport::Notifications.subscribe(/^render_(template|action|collection)\.action_view/) do |*args|
      next unless Trace.current
      event = ActiveSupport::Notifications::Event.new(*args)
      Trace.current.add(event)
    end

    ActiveSupport::Notifications.subscribe('process_action.action_controller') do |*args|
      next unless Trace.current
      event = ActiveSupport::Notifications::Event.new(*args)
      if event.payload[:controller] && event.payload[:action]
        Trace.current.complete(event)
      end
    end
  end
end
