module Lens
  module Compression
    module Gzip
      def self.compress(data)
        GzipUtil.gzip(data)
      end

      def self.headers
        { 'Content-Encoding' => 'gzip' }
      end
    end
  end
end
