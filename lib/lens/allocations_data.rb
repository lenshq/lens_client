require 'objspace'

module Lens
  class AllocationsData
    attr_reader :objects_count, :objects_memory

    def initialize
      @objects_count  = get_count
      @objects_memory = get_memory
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
