require 'spec_helper'

RSpec.describe Lens::Trace do
  describe '.process' do
    before { Lens.configure { |config| config.show_memory_usage = true } }

    let(:first_event) { generate_event('start_processing.action_controller') }
    let(:last_event) { generate_event('process_action.action_controller') }

    context 'when first message' do
      before { described_class.process(first_event) }

      it 'creates new thread' do
        expect(described_class.present?).to be true
      end
    end

    context 'when last message' do
      before do
        Lens::Worker.start({})
        allow_any_instance_of(Lens::Worker).to receive :push
      end

      it 'kills thread' do
        described_class.process(first_event)
        expect(described_class.present?).to be true

        described_class.process(last_event)
        expect(described_class.present?).to be false
      end

      it 'pushes data to lens server' do
        expect_any_instance_of(Lens::Worker).to receive :push
        described_class.process(first_event)
        described_class.process(last_event)
      end
    end
  end
end

def generate_event(name = 'event_name')
  Lens::Event.new(
    name: name,
    started: Time.current,
    finished: Time.current,
    transaction_id: 1,
    payload: {
      controller: 'controller',
      action: 'action'
    }
  )
end
