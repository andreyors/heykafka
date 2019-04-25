# frozen_string_literal: true

module HeyKafka
  class Producer
    def initialize(client:)
      @client = client
    end

    def send_message(message:, topic:)
      @client.deliver_message(message.to_json, topic: topic)
    end
  end
end
