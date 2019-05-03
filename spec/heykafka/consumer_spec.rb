# frozen_string_literal: true

require 'spec_helper'

module Consumers
  class TestConsumer < ::HeyKafka::Consumer
    def topic
      'test_passed'
    end

    def group
      'test_group'
    end

    def process(payload)
      logger.info("Message: #{payload}")
    end

    private

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
  end
end

RSpec.describe HeyKafka::Consumer do
  let(:consumer) { described_class.new }
  let(:real_consumer) { Consumers::TestConsumer.new }
  
  describe '#topic' do
    subject { consumer.topic }

    it 'throws an error' do
      expect { subject }.
        to raise_error NotImplementedError, 'Please implement topic'
    end
  end

  describe '#group' do
    subject { consumer.group }

    it 'throws an error' do
      expect { subject }.
        to raise_error NotImplementedError, 'Please implement topic'
    end
  end

  describe '#process' do
    subject { consumer.process(payload) }

    let(:payload) { 'payload' }

    it 'throws an error' do
      expect { subject }.
        to raise_error NotImplementedError, 'Please implement process'
    end
  end

  describe '#run' do
    subject { real_consumer.run }

    let(:client) { double(HeyKafka::Client).as_null_object }
    let(:consumer) { double(Kafka::Consumer).as_null_object }
    let(:message) { instance_double(Kafka::FetchedMessage) }
    let(:payload) do
      {
        time: 'now'
      }.to_json
    end
    let(:topic) { 'test_passed' }
    let(:logger) { instance_double(::Logger) }

    before do
      allow(::HeyKafka::Client).
        to receive_message_chain(:new, :connect).
        and_return(client)

      allow(HeyKafka::Validator).
          to receive(:validate!)

      allow(client).
        to receive(:consumer).
        with(group_id: 'test_group').
        and_return(consumer)

      allow(consumer).
        to receive(:subscribe).
        with(topic)

      allow(consumer).
        to receive(:each_message).
        with(automatically_mark_as_processed: false).
        and_yield(message)

      allow(message).
        to receive(:value).
        and_return(payload)

      allow(consumer).
        to receive(:mark_as_processed).
        with(message)

      allow(consumer).
        to receive(:commit_offsets)

      allow(::Logger).
        to receive(:new).
        with(STDOUT).
        and_return(logger)

      allow(logger).
        to receive(:info)
    end

    it 'logs the events' do
      expect(logger).
        to receive(:info)

      expect(client).
        to receive(:consumer).
        and_return(consumer)
      
      subject
    end
  end
end
