# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HeyKafka::Client do
  let(:client) { described_class.new }
  let(:logger) { instance_double(::Logger) }

  describe '#connect' do
    subject { client.connect }

    before do
      allow(Kafka).
        to receive(:new).
        with([server_url], client_id: client_id)

      allow(::Logger).
        to receive(:new).
        and_return(logger)

      allow(logger).
        to receive(:info)
    end

    context 'when no credentials were provided' do
      let(:server_url) { 'kafka:9092' }
      let(:client_id) { 'default' }

      it 'makes a call' do
        expect(Kafka).
          to receive(:new)

        subject
      end

      it 'logs after connection to client created' do
        expect(logger).
          to receive(:info).
          with("Connected client to broker #{server_url}")

        subject
      end
    end

    context 'when credentials were provided via ENV' do
      let(:server_url) { 'test-kafka:9092' }
      let(:client_id) { 'test-client' }

      before do
        allow(ENV).
          to receive(:[]).
          with('KAFKA_SERVER').
          and_return(server_url)

        allow(ENV).
          to receive(:[]).
          with('KAFKA_CLIENT_ID').
          and_return(client_id)
      end

      it 'makes a call' do
        expect(Kafka).
          to receive(:new)

        subject
      end

      it 'logs after connection to client created' do
        expect(logger).
          to receive(:info).
          with("Connected client to broker #{server_url}")

        subject
      end
    end
  end
end
