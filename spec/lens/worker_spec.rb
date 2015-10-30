require 'spec_helper'

describe Lens::Worker do
  let(:worker) { Lens::Worker.new({}) }

  describe '.stop' do
    before { Lens::Worker.start({}) }

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
