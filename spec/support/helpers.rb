module Helpers
  def stub_http(options = {})
    response = options[:response] || Net::HTTPSuccess.new('1.2', '200', 'OK')
    response.stub(:body => options[:body] || '{"id":"1234"}')
    http = double(
      :post          => response,
      :read_timeout= => nil,
      :open_timeout= => nil,
      :ca_file=      => nil,
      :verify_mode=  => nil,
      :use_ssl=      => nil
    )
    Net::HTTP.stub(:new).and_return(http)
    http
  end

  def reset_config
    Lens.configuration = nil
    Lens.configure do |config|
      config.app_key = 'app_key_123'
      config.secret = 'abc123'
    end
  end
end
