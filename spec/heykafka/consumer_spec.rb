# frozen_string_literal: true

require 'spec_helper'

RSpec.describe HeyKafka::Consumer do
  let(:consumer) { described_class.new }

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
end
