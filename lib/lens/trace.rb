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
      log(formatted_data)
      send(formatted_data)
      Thread.current[:__lens_trace] = nil
    end

  private

    def send(data)
      log(data)
      Lens.sender.send_to_lens(data)
    end

    def log(data)
      Rails.logger.info "all [LENS] >>> #{data}" if verbose?
    end

    def verbose?
      false
    end
  end

  class << Trace
    def process(*args)
      name, _started, _finished, id, _data = [*args]
      event = ActiveSupport::Notifications::Event.new(*args)

      if name == 'start_processing.action_controller'
        create(id)
        Trace.current.add(event)
      else
        return if Trace.current.blank?

        Trace.current.add(event)
        if name == 'process_action.action_controller'
          Trace.current.complete(event) if event.payload[:controller] && event.payload[:action]
        end
      end
    end

    def current
      Thread.current[:__lens_trace]
    end

    def create(id)
      Thread.current[:__lens_trace] = new(id)
    end
  end
end
