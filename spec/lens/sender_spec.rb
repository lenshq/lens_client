require 'spec_helper'
require 'support/helpers'

describe Lens::Sender do
  before { reset_config }
  let(:http) { stub_http }

  it "makes a single request when sending notices" do
    http.should_receive(:post).once
    Lens.sender.send_to_lens('abc123')
  end

end
