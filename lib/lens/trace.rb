require 'rails'

module Lens
  class Trace
    def initialize(id)
      @id = id
      @data = []
    end

    def add(event)
      @data.push event.payload
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
      Lens.sender.send_to_lens(data)
    end

    def log(data)
      Rails.logger.info "all [LENS] >>> #{data}" if verbose?
    end

    def verbose?
      true
    end
  end

  class << Trace
    def current
      Thread.current[:__lens_trace]
    end

    def create(id)
      Thread.current[:__lens_trace] = new(id)
    end
  end
end
