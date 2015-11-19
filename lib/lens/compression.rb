require 'lz4-ruby'

module Lens
  module Compression
    module Gzip
      def self.compress(data)
        GzipUtil.gzip(data)
      end

      def self.headers
        { 'Content-Type' => 'gzip/json' }
      end
    end

    module LZ4
      def self.compress(data)
        ::LZ4::compress(data)
      end

      def self.headers
        { 'Content-Type' => 'lz4/json' }
      end
    end

    module LZ4HC
      def self.compress(data)
        ::LZ4::compressHC(data)
      end

      def self.headers
        { 'Content-Type' => 'lz4hc/json' }
      end
    end
  end
end
