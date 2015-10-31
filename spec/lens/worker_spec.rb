require 'spec_helper'

describe Lens::Worker do
  let(:worker) { Lens::Worker.new({}) }
  before { Lens::Worker.start({}) }
  after { Lens::Worker.stop }

  describe '.start' do
    it 'creates thread' do
      Lens::Worker.stop
      expect(Lens::Worker.instance).to be nil

      Lens::Worker.start({})
      expect(Lens::Worker.instance).to be_truthy
    end

    context 'when started twice' do
      it 'creates thread' do
        Lens::Worker.stop
        expect(Lens::Worker.instance).to be nil

        Lens::Worker.start({})
        first_instance = Lens::Worker.instance
        Lens::Worker.start({})
        expect(Lens::Worker.instance).to eq first_instance
      end
    end
  end

  describe '.stop' do
    before { Lens::Worker.start({}) }

    it 'sets running? to false' do
      Lens::Worker.stop(force: true)
      expect(Lens::Worker.running?).to be false
    end

    context 'when forced' do
      it 'calls forced stop' do
        expect_any_instance_of(Lens::Worker).to receive :shutdown!
        Lens::Worker.stop(force: true)
      end
    end

    context 'when graceful' do
      it 'calls graceful stop' do
        expect_any_instance_of(Lens::Worker).to receive :shutdown
        Lens::Worker.stop
      end
    end

    context 'when stopped twice' do
      it 'doesnt raise errors' do
        2.times { Lens::Worker.stop }
        expect { Lens::Worker }.not_to raise_error
      end
    end
  end

  describe '#process' do
    let(:sender) { spy }

    before do
      Lens.sender = sender
      worker.start
    end

    it 'sends data to lens' do
      worker.process({})
      expect(sender).to have_received :send_to_lens
    end
  end

  describe '#shutdown!' do
    it 'kills thread thread immediately' do
      worker.start
      expect(worker.thread).to be_truthy

      worker.shutdown!
      expect(worker.thread.stop?).to be true
    end
  end

  describe '#shutdown' do
    it 'kills thread thread' do
      worker.start
      expect(worker.thread).to be_truthy

      worker.shutdown
      expect(worker.thread.stop?).to be true
    end
  end
end

describe Lens::Worker::Queue do
  let(:queue) { described_class.new(max_size: 1) }

  describe '#push' do
    context 'when queue is full' do
      before { 2.times { queue.push({}) } }
      subject { queue.length }

      it { is_expected.to eq 1 }
    end
  end
end
