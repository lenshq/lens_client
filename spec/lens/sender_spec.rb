require 'spec_helper'

describe Lens::Sender do
  def reset_config
    Lens.configuration = nil
    Lens.configure do |config|
      config.app_id = 'app_key_123'
      config.secret = 'abc123'
    end
  end

  def stub_http(options = {})
    response = options[:response] || Net::HTTPSuccess.new('1.2', '200', 'OK')
    response.stub(:body => options[:body] || '{"id":"1234"}')
    http = double(:post          => response,
                :read_timeout= => nil,
                :open_timeout= => nil,
                :ca_file=      => nil,
                :verify_mode=  => nil,
                :use_ssl=      => nil)
    Net::HTTP.stub(:new).and_return(http)
    http
  end

  before { reset_config }
  let(:http) { stub_http }

  it "makes a single request when sending notices" do
    http.should_receive(:post).once
    Lens.sender.send_to_lens('abc123')
  end

end
