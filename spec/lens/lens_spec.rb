require 'spec_helper'
require 'support/helpers'

describe Lens do
  describe '.configure' do
    context 'when user params' do
      let(:params) do
        {
          app_key: 'secret-key',
          protocol: 'https',
          host: 'example.com',
          port: 8080
        }
      end
      before { configure(params) }
      subject { described_class.configuration }

      it { expect(subject.app_key).to eq params[:app_key] }
      it { expect(subject.protocol).to eq params[:protocol] }
      it { expect(subject.host).to eq params[:host] }
      it { expect(subject.port).to eq params[:port] }
    end

    context 'when default params' do
      describe 'compressor' do
        subject { described_class.configuration.compressor }

        it { is_expected.to respond_to :compress }
        it { is_expected.to be Lens::Compression::Gzip }
      end

      describe 'configuration' do
        subject { described_class.configuration }

        it { expect(subject.app_key).to eq nil }
        it { expect(subject.protocol).to eq 'http' }
        it { expect(subject.host).to eq 'lenshq.io' }
        it { expect(subject.port).to eq 80 }
      end
    end
  end

  describe '.start' do
    subject { described_class.start }

    it { expect { subject }.to raise_error Lens::ConfigurationError }
  end
end

def configure(params)
  described_class.configure do |config|
    config.app_key = params[:app_key]
    config.protocol = params[:protocol]
    config.host = params[:host]
    config.port = params[:port]
  end
end
