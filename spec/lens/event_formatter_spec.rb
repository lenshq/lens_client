require 'spec_helper'

describe Lens::EventFormatter do
  let(:event) { double(payload: {}, duration: 2.33) }
  let(:records) { [] }
  let(:formatter) { Lens::EventFormatter.new(event, records) }

  describe "#formatted" do
    subject { formatter.formatted }

    it "returns hash" do
      expect(subject).to be_a(Hash)
    end

    it "has data key" do
      expect(subject).to have_key(:data)
    end

    it "data key is not empty" do
      expect(subject[:data]).to_not be_empty
    end

    it "required fields are present" do
      required_keys = [:action, :controller, :params, :method, :url, :records, :time, :duration]
      expect(required_keys - subject[:data].keys).to be_empty
    end
  end
end
