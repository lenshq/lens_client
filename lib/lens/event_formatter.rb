module Lens
  class EventFormatter
    def initialize(event, records, allocations_data, gc_time = 0.0)
      @event = event
      @records = records.map{|payload| filter_payload(payload)}
      @gc_time = 0.0
      @allocations_data = allocations_data
    end

    def json_formatted
      formatted.to_json
    end

    def formatted
      @formatted ||= { data: event_data }
    end

  private

    def event_payload
      @event_payload ||= filter_payload(@event.payload)
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
        gc_time: @gc_time,
        event_name: @event.name,
        meta: {
          client_version: VERSION,
          rails_version: ::Rails.version
        },
        objects_count: @allocations_data.objects_count,
        objects_memory: @allocations_data.objects_memory
      }
    end

    def filter_payload(payload)
      payload.inject({}) do |res, h|
        k, v = h

        if v.is_a?(Hash)
          res[k] = filter_payload(v)
        elsif v.is_a?(File)
          res[k] = {type: :file, path: v.path}
        elsif v.is_a?(ActionDispatch::Http::UploadedFile)
          res[k] = {
            content_type: v.content_type,
            headers: v.headers,
            original_filename: v.original_filename,
            tempfile_path: v.tempfile.path
          }
        else
          res[k] = v
        end

        res
      end
    end
  end
end
