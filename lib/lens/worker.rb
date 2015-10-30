module Lens
  class Worker
    # A queue which enforces a maximum size.
    # NOTE: can be replaced with SizedQueue?
    class Queue < ::Queue
      attr_reader :max_size

      def initialize(options = {})
        raise ArgumentError unless options[:max_size]

        @max_size = options[:max_size]
        super()
      end

      def push(obj)
        super unless size >= max_size
      end
    end

    class << self
      def instance
        @instance
      end

      def running?
        !instance.nil?
      end

      def start(config)
        return instance if running?
        @instance = new(config)
      end

      def stop(options = {})
        @instance.send(options[:force] ? :shutdown! : :shutdown)
      end
    end

    SHUTDOWN = :__lens_worker_shutdown!

    attr_reader :config, :queue, :pid, :mutex, :thread

    def initialize(config)
      @config = config
      @queue = Queue.new(max_size: 100)
      @mutex = Mutex.new
      @shutdown = false
      start
    end

    def push(obj)
      if start
        queue.push(obj)
      end
    end

    def start
      mutex.synchronize do
        return false if @shutdown
        return true if thread && thread.alive?

        @pid = Process.pid
        @thread = Thread.new { run }
      end

      true
    end

    def run
      begin
        loop do
          case msg = queue.pop
          when SHUTDOWN
            break
          else
            process(msg)
          end
        end
      end
    rescue Exception => e
    end

    def process(msg)
      handle_response(notify_backend(msg))
    rescue StandardError => e
      sleep(1)
    end

    def notify_backend(payload)
      Lens.sender.send_to_lens(payload)
    end

    def handle_response(response)
      # TODO: send message back to queue if response status != 200
      log "handle_response #{response.code}"
    end

    # Shutdown the worker after sending remaining data.
    # Returns true.
    def shutdown
      mutex.synchronize do
        @shutdown = true
        @pid = nil
        queue.push(SHUTDOWN)
      end

      return true unless thread

      r = true
      unless Thread.current.eql?(thread)
        begin
          r = !!thread.join
        ensure
          shutdown! unless r
        end
      end

      r
    end

    # Immediate shutdown
    def shutdown!
      mutex.synchronize do
        @shutdown = true
        @pid = nil
      end

      if thread
        Thread.kill(thread)
        thread.join # Allow ensure blocks to execute.
      end

      true
    end
  end
end
