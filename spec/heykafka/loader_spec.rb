# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::HeyKafka::Loader do
  let(:loader) { described_class.new }

  let(:app_folder) { '/tmp' }
  let(:content) do
    'module ::Consumers
      class TestConsumer < ::HeyKafka::Consumer
      end
    end'
  end
  let(:consumer_file) { "#{app_folder}#{HeyKafka::Loader::CONSUMER_PATH}#{name}_consumer.rb" }
  let(:consumer_dir) { File.dirname(consumer_file) }

  describe '#classify' do
    subject { loader.classify(name) }

    let(:name) { 'test' }
    
    context 'when consumer exists' do
      before do
        allow(::Dir).
          to receive(:pwd).
          and_return(app_folder)

        FileUtils.mkdir_p(consumer_dir) unless File.exist?(consumer_dir)
        File.delete(consumer_file) if File.exist?(consumer_file)
        File.write(consumer_file, content)
      end

      after do
        FileUtils.rm_rf(consumer_dir) if File.exist?(consumer_dir)
      end

      it 'calls a consumer' do
        expect(subject).
          to be_kind_of ::HeyKafka::Consumer
      end
    end

    context 'when consumer does not exists' do
      it 'throws LoadError' do
        expect { subject }.
          to raise_error LoadError, "Cannot find #{name} consumer in #{HeyKafka::Loader::CONSUMER_PATH}"
      end
    end
  end
end
