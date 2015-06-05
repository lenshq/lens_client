module Lens
  class EventFormatter
    def initialize(event, records)
      @event = event
      @records = records
    end

    def json_formatted
      formatted.to_json
    end

    def formatted
      @formatted ||= { data: event_data }
    end

  private

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
        time: Time.now,
        start: @event.time.to_f,
        end: @event.end.to_f,
        duration: @event.duration,
        event_name: @event.name,
        meta: {
          client_version: VERSION
        }
      }
    end
  end
end
