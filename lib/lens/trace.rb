require 'rails'

module Lens
  class Trace
    def initialize(id)
      @id = id
      @data = []

      @gc_statistics = Lens::GC.new
      @gc_statistics.enable
    end

    def add(event)
      @data.push event.payload.merge(
        etype: event.name,
        eduration: event.duration,
        estart: event.time.to_f,
        efinish: event.end.to_f
      )
    end

    def complete(event)
      formatted_data = Lens::EventFormatter.new(event, @data, @gc_statistics.total_time).json_formatted
      send(formatted_data)
      Thread.current[:__lens_trace] = nil
    end

    private

    def send(data)
      Worker.instance.push(data)
    end
  end

  class << Trace
    def process(*args)
      _name, _started, _finished, id, _data = args
      event = ActiveSupport::Notifications::Event.new(*args)

      create(id) if first_event?(event)

      if Trace.current.present?
        Trace.current.add(event)
        Trace.current.complete(event) if last_event?(event)
      end
    end

    private

    def first_event?(event)
      event.name == 'start_processing.action_controller'
    end

    def last_event?(event)
      event.name == 'process_action.action_controller' &&
        event.payload[:controller] &&
        event.payload[:action]
    end

    def current
      Thread.current[:__lens_trace]
    end

    def create(id)
      Thread.current[:__lens_trace] = new(id)
    end
  end
end
