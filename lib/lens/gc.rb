module Lens
  if defined?(::GC::Profiler)
    class GC
      def initialize
        @total = 0
      end

      def enable
        ::GC::Profiler.enable
      end

      def total_time
        run = ::GC::Profiler.total_time

        if run > 0
          ::GC::Profiler.clear
        end

        @total += run
      end
    end
  end

  unless defined?(::Lens::GC)
    class GC
      def enable; end
      def total_time; 0.0; end
    end
  end
end
