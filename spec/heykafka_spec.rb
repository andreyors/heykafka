# frozen_string_literal: true

RSpec.describe HeyKafka do
  it 'has a version number' do
    expect(HeyKafka::VERSION).
      not_to be nil
  end
end
