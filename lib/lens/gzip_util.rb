require 'zlib'
require 'stringio'
# Source: http://code-dojo.blogspot.ru/2012/10/gzip-compressiondecompression-in-ruby.html

module GzipUtil
  def self.gunzip(data)
    io = StringIO.new(data, "rb")
    gz = Zlib::GzipReader.new(io)
    decompressed = gz.read
  end

  def self.gzip(string)
    wio = StringIO.new("w")
    w_gz = Zlib::GzipWriter.new(wio)
    w_gz.write(string)
    w_gz.close
    compressed = wio.string
  end
end