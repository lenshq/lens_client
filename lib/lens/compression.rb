require 'bson'
require 'beefcake'
require 'lz4-ruby'

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

    module Protobuf
      class Record
        include Beefcake::Message

        required :etype, :string, 1
        required :eduration, :float, 2
        required :etype, :string, 3
        required :estart, :float, 4
        required :efinish, :float, 5

        optional :sql, :string, 6
        optional :name, :string, 7
        optional :connection_id, :int32, 8
        optional :identifier, :string, 9
        optional :virtual_path, :string, 10

        # repeated :binds, :string, 11, :packed => true
      end

      class Batch
        include Beefcake::Message
        repeated :records, Record, 1, :packed => true
      end

      def self.compress(data)
        b = Batch.new(:records => [])
        JSON.parse(data, :symbolize_names => true)[:records].map do |rec|
          b.records << Record.new(rec)
        end

        aaa = b.encode.to_s
        # require 'pry'; binding.pry
        # Batch.decode(aaa)
      end

      def self.headers
        {}
      end
    end

    module ProtobufGzip
      def self.compress(data)
        GzipUtil.gzip(Protobuf.compress(data))
      end

      def self.headers
        {}
      end
    end

    module Bson
      def self.compress(data)
        JSON.parse(data).to_bson
      end

      def self.headers
        {}
      end
    end

    module BsonGzip
      def self.compress(data)
        # data.to_bson
        GzipUtil.gzip(JSON.parse(data).to_bson)
      end

      def self.headers
        {'Content-Encoding' =>'gzip'}
      end
    end

    module LZ4
      def self.compress(data)
        ::LZ4::compress(data)
      end

      def self.headers
        {}
      end
    end

    module LZ4HC
      def self.compress(data)
        ::LZ4::compressHC(data)
      end

      def self.headers
        {}
      end
    end
  end
end
