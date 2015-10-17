require 'bson'

module Lens
  module Compression
    module Gzip
      def self.compress(data)
        GzipUtil.gzip(data)
      end

      def self.headers
        {'Content-Encoding' =>'gzip'}
      end
    end

    module Void
      def self.compress(data)
        data
      end

      def self.headers
        {}
      end
    end

    module Bson
      def self.compress(data)
        data.to_bson
      end

      def self.headers
        {}
      end
    end
  end
end