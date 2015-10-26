require 'spec_helper'
require 'support/helpers'

describe Lens::Sender do
  before { reset_config }
  let(:http) { stub_http }

  it "makes a single request when sending notices" do
    expect(http).to receive(:post).once
    Lens.sender.send_to_lens('abc123')
  end
end
