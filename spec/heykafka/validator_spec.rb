# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HeyKafka::Validator do
  let(:validator) { described_class }

  describe '.validate' do
    subject { validator.validate!(payload: payload, topic: topic) }

    let(:payload) { '' }
    let(:topic) { 'test' }
    let(:json_schema) do
      {
        'type' => 'object',
        'required' => ['a'],
        'properties' => {
          'a' => { 'type' => 'integer' }
        }
      }.to_json
    end

    context 'when schema can be found' do
      before do
        allow(File).
          to receive(:read).
          and_return(json_schema)
      end

      context 'and schema is invalid' do
        let(:json_schema) do
          '{'
        end

        it 'throws JSON::ParserError' do
          expect { subject }.
            to raise_error JSON::ParserError
        end
      end

      context 'and payload is valid' do
        context 'and correct payload provided' do
          let(:payload) do
            {
              'a' => 5
            }.freeze
          end

          it { is_expected.to eq(true) }
        end
      end

      context 'and payload is invalid' do
        context 'and payload is empty' do
          let(:payload) { nil }

          it 'throws a ValidationError' do
            expect { subject }.
              to raise_error JSON::Schema::ValidationError
          end
        end

        context 'and payload is completely broken' do
          let(:payload) do
            '{'
          end

          it 'throws a ValidationError' do
            expect { subject }.
              to raise_error JSON::Schema::ValidationError
          end
        end

        context 'and payload is breaking an constraint' do
          let(:payload) do
            {
              'a' => 'asd'
            }.freeze
          end

          it 'throws a ValidationError' do
            expect { subject }.
              to raise_error JSON::Schema::ValidationError
          end
        end
      end
    end

    context 'when schema cannot be found' do
      it 'throws a SchemaNotFoundError' do
        expect { subject }.
          to raise_error HeyKafka::SchemaNotFoundError
      end
    end
  end
end
