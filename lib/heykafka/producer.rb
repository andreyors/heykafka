# frozen_string_literal: true

module HeyKafka
  class Producer
    class << self
      def send_message(message:, topic:)
        payload = message.to_json

        client.deliver_message(payload, topic: topic)
      end

      private

      def client
        ::HeyKafka::Client.new.connect
      end
    end
  end
end
