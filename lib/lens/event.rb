module Lens
  class Event
    attr_reader :name, :time, :end, :transaction_id, :payload

    def initialize(options = {})
      raise ArgumentError unless all_params_present?(options)

      @name = options[:name]
      @time = options[:started]
      @end = options[:finished]
      @transaction_id = options[:transaction_id]
      @payload = options[:payload]
    end

    def duration
      1000.0 * (self.end - time)
    end

    private

    def all_params_present?(options)
      [:name, :started, :finished, :transaction_id, :payload].all? do |key|
        options.key? key
      end
    end
  end
end
