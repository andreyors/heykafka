# frozen_string_literal: true

module Consumers
  class TestConsumer < ::HeyKafka::Consumer
    def topic
      'test'
    end

    def process(payload)
      Rails.logger.info "Test Consumer is active, payload: #{JSON.parse(payload)}"
    end
  end
end
