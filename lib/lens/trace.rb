require 'rails'

module Lens
  class Trace
    def self.current
      Thread.current[:__lens_trace]
    end

    def self.create(id)
      Thread.current[:__lens_trace] = new(id)
    end

    def initialize(id)
      @id = id
      @data = []
    end

    def add(event)
      @data.push event.payload
    end

    def complete(event)
      formatted_data = format(event, @data)
      Rails.logger.info "all [LENS] >>> #{formatted_data}"
      Lens.sender.send_to_lens(formatted_data)
      Thread.current[:__lens_trace] = nil
    end

    def format(complete_event, records)
      payload = complete_event.payload
      {
        data:
          {
            action: payload[:action],
            controller: payload[:controller],
            params: payload[:params],
            method: payload[:method],
            url: payload[:path],
            records: records,
            duration: complete_event.duration,
            meta: {
              client_version: VERSION
            }
          }
      }
    end
  end
end
