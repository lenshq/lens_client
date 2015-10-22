module Lens
  if RUBY_ENGINE == 'ruby' && RUBY_VERSION >= '1.9'
    require 'objspace'

    class AllocationsData
      def initialize
        @enabled        = false
        @objects_count  = 0
        @objects_memory = 0
      end

      def enable
        @enabled = true
      end

      def objects_count
        @objects_count = get_count if @enabled
        @objects_count
      end

      def objects_memory
        @objects_memory = get_memory if @enabled
        @objects_memory
      end

      private

      def get_count
        obj_count = ObjectSpace.count_objects
        obj_count[:TOTAL] - obj_count[:FREE]
      end

      def get_memory
        ObjectSpace.count_objects_size[:TOTAL]
      end
    end
  end

  unless defined?(::Lens::AllocationsData)
    class AllocationsData
      def enable; end
      def objects_count; 0; end
      def objects_memory; 0; end
    end
  end
end
