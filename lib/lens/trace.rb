module Lens
  class Trace
    def initialize(id)
      @id = id
      @data = []

      @gc_statistics = Lens::GC.new
      @gc_statistics.enable

      @allocations_data = Lens::AllocationsData.new
      @allocations_data.enable if Lens.configuration.with_memory_usage?
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
      formatter = Lens::EventFormatter.new(
        event,
        @data,
        @gc_statistics.total_time,
        @allocations_data
      )
      formatted_data = formatter.json_formatted
      send(formatted_data)
      Thread.current[:__lens_trace] = nil
    end

    private

    def send(data)
      Worker.instance.push(data)
    end
  end

  class << Trace
    def process(event)
      create(event.transaction_id) if first_event?(event)

      if Trace.present?
        current.add(event)
        current.complete(event) if last_event?(event)
      end
    end

    def present?
      current.present?
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
