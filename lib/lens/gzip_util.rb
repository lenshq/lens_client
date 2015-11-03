require 'zlib'
require 'stringio'

module GzipUtil
  def self.gzip(string)
    io = StringIO.new('w')
    writer = Zlib::GzipWriter.new(io)
    writer.write(string)
    writer.close
    io.string
  end
end
