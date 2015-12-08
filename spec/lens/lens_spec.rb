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
          port: 8080,
          show_memory_usage: true
        }
      end
      before { configure(params) }
      subject { described_class.configuration }

      it { expect(subject.app_key).to eq params[:app_key] }
      it { expect(subject.protocol).to eq params[:protocol] }
      it { expect(subject.host).to eq params[:host] }
      it { expect(subject.port).to eq params[:port] }
      it { expect(subject.with_memory_usage?).to eq params[:show_memory_usage] }
    end

    context 'when default params' do
      describe 'compressor' do
        subject { described_class.configuration.compressor }

        it { is_expected.to respond_to :compress }
        it { is_expected.to be Lens::Compression::LZ4 }
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
    context 'without configuration' do
      subject { described_class.start }

      it { expect { subject }.to raise_error Lens::ConfigurationError }
    end

    context 'with configuration' do
      let(:params) { { app_key: 'some_key' } }

      around(:example) do |example|
        configure(params)
        described_class.start

        example.run

        described_class.stop
      end

      it 'client has been started properly' do
        expect(Lens::Worker.running?).to be_truthy
      end
    end
  end

  describe '.stop' do
    context 'not running' do
      it 'client has been stopped properly' do
        expect(Lens::Worker.running?).to be_falsey
        described_class.stop
        expect(Lens::Worker.running?).to be_falsey
      end
    end

    context 'running' do
      let(:params) { { app_key: 'some_key' } }

      around(:example) do |example|
        configure(params)
        described_class.start

        example.run

        described_class.stop
      end

      it 'client has been stopped properly' do
        expect(Lens::Worker.running?).to be_truthy
        described_class.stop
        expect(Lens::Worker.running?).to be_falsey
      end
    end
  end
end

def configure(params)
  described_class.configure do |config|
    config.app_key = params[:app_key] if params[:app_key].present?
    config.protocol = params[:protocol] if params[:protocol].present?
    config.host = params[:host] if params[:host].present?
    config.port = params[:port] if params[:port].present?
    config.show_memory_usage = params[:show_memory_usage] if params[:show_memory_usage].present?
  end
end
