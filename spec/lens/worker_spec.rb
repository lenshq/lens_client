require 'spec_helper'

describe Lens::Worker do
  describe '#process' do
    before { allow(Lens::Sender).to receive :send_to_lens }

    it 'sends data to lens' do
      expect_any_instance_of(Lens::Sender).to receive :send_to_lens
      Lens::Worker.new({}).process({})
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
end
