require 'rails'

module Lens
  class Trace
    def initialize(id)
      @id = id
      @data = []
    end

    def add(event)
      @data.push event.payload.merge(
        etype: event.name,
        eduration: event.duration,
        estart: event.time,
        efinish: event.end
      )
    end

    def complete(event)
      formatted_data = Lens::EventFormatter.new(event, @data).json_formatted
      log(formatted_data)
      send(formatted_data)
      Thread.current[:__lens_trace] = nil
    end

  private

    def send(data)
      log(data)
      # Lens.sender.send_to_lens(data)
    end

    def log(data)
      Rails.logger.info "all [LENS] >>> #{data}" if verbose?
    end

    def verbose?
      true
    end
  end

  class << Trace
    def process(*args)
      name, _started, _finished, id, _data = [*args]

      if name == 'start_processing.action_controller'
        create(id)
      else
        return if Trace.current.blank?

        event = ActiveSupport::Notifications::Event.new(*args)

        case name
        when 'sql.active_record'
          Trace.current.add(event) #if event.payload[:name] != 'SCHEMA'
        when 'process_action.action_controller'
          Trace.current.complete(event) if event.payload[:controller] && event.payload[:action]
        else
          Trace.current.add(event)
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
