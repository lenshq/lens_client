require 'spec_helper'

describe Lens::Worker do
  let(:worker) { Lens::Worker.new({}) }

  describe '#process' do
    before do
      allow(Lens::Sender).to receive :send_to_lens
      worker.start
    end

    it 'sends data to lens' do
      expect_any_instance_of(Lens::Sender).to receive :send_to_lens
      worker.process({})
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
  let(:queue) { described_class.new(1) }

  describe '#push' do
    context 'when queue is full' do
      before { 2.times { queue.push({}) } }
      subject { queue.length }

      it { is_expected.to eq 1 }
    end
  end
end
