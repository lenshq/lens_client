module Lens
  class EventFormatter
    def initializer(event, records)
      @event = event
      @records = records
    end

    def event_payload
      @event_payload ||= @event.payload
    end

    def event_data
      @event_data ||=
      {
        action: event_payload[:action],
        controller: event_payload[:controller],
        params: event_payload[:params],
        method: event_payload[:method],
        url: event_payload[:path],
        records: @records,
        duration: @event.duration,
        meta: {
          client_version: VERSION
        }
      }
    end

    def format
      {
        data: event_data
      }
    end
  end
end