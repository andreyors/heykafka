# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::HeyKafka::ConsumerRunner do
  let(:runner) { described_class.new }

  describe '#execute' do
    subject { runner.parse!(options).call }

    let(:options) do
      [
          argument
      ]
    end
    let(:argument) { 'test' }

    before do
      suppress_output
    end

    context 'when correct argument provided' do
      let(:logger) { instance_double(Logger) }
      let(:loader) { instance_double(::HeyKafka::Loader) }
      let(:consumer) { instance_double(::HeyKafka::Consumer) }

      before do
        allow(Logger).
          to receive(:new).
          with(STDOUT).
          and_return(logger)

        allow(logger).
          to receive(:info).
          twice

        allow(::HeyKafka::Loader).
          to receive(:new).
          and_return(loader)

        allow(loader).
          to receive(:classify).
          and_return(consumer)

        allow(consumer).
          to receive(:run)
      end

      it 'logs tracing details' do
        expect(logger).
          to receive(:info).
          once.
          with("[CLI] Starting consumer #{argument}")

        expect(logger).
          to receive(:info).
          once.
          with("[CLI] Stopping consumer #{argument}")

        subject
      end

      it 'calls the loader' do
        expect(loader).
          to receive(:classify).
          with(argument)

        subject
      end

      it 'executes the consumer' do
        expect(consumer).
          to receive(:run)

        subject
      end
    end

    context 'when invalid argument provided' do
      context 'when no arguments provided' do
        let(:options) do
          []
        end

        it 'throws an ArgumentError' do
          expect { subject }.
            to raise_error ArgumentError, 'Please provide consumer name'
        end
      end

      context 'and no such consumer exists' do
        let(:argument) { 'do-not-exists' }

        it 'throws LoadError' do
          expect { subject }.
            to raise_error LoadError, "Cannot find #{argument} consumer in #{HeyKafka::Loader::CONSUMER_PATH}"
        end
      end
    end
  end
end
