# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ::HeyKafka::Producer do
  let(:producer) { described_class }

  describe '.send_message' do
    subject { producer.send_message }
  end
end
