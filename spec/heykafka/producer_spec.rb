# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::HeyKafka::Producer do
  let(:producer) { described_class }

  describe '.send_message' do
    subject { producer.send_message(message: message, topic: topic) }

    let(:message) do
      {
        data: 1
      }
    end
    let(:payload) do
      message.to_json
    end
    let(:topic) { 'test_passed' }
    let(:client) { double(HeyKafka::Client).as_null_object }
        
    before do
      allow(HeyKafka::Validator).
        to receive(:validate!)

      allow(::HeyKafka::Client).
        to receive_message_chain(:new, :connect).
        and_return(client)

      allow(client).
        to receive(:deliver_message)
    end

    it 'calls a validator' do
      expect(HeyKafka::Validator).
        to receive(:validate!).
        with(payload: payload, topic: topic)

      subject
    end

    it 'delivers a message' do
      expect(client).
        to receive(:deliver_message).
        with(payload, topic: topic)

      subject
    end
  end
end
