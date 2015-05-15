require 'rails'

module Lens
  class Trace
    attr_reader :id, :duration

    def self.current
      Thread.current[:__lens_trace]
    end

    def self.create(id)
      Thread.current[:__lens_trace] = new(id)
    end

    def initialize(id)
      @id = id
      @events = []
      @duration = 0
    end

    def add(event)
      @events.push event
    end

    def complete(event)
      @duration = event.duration
      Rails.logger.info "all [LENS] >>> #{@events}"
      Rails.logger.info "last [LENS] >>> #{event}"
      Thread.current[:__lens_trace] = nil
    end
  end
end
