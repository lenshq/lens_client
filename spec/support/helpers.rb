module Helpers
  def stub_http(options = {})
    response = options[:response] || Net::HTTPSuccess.new('1.2', '200', 'OK')
    allow(response).to receive(:body).with(options[:body] || '{"id":"1234"}')
    http = double(
      :post          => response,
      :read_timeout= => nil,
      :open_timeout= => nil,
      :ca_file=      => nil,
      :verify_mode=  => nil,
      :use_ssl=      => nil
    )
    allow(Net::HTTP).to receive(:new).and_return(http)
    http
  end
end
