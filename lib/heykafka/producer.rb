# frozen_string_literal: true

module HeyKafka
  class Producer
    class << self
      attr_writer :logger

      def send_message(message:, topic:)
        payload = message.to_json

        validator.validate!(payload: payload, topic: topic)
        logger.info("[Producer] Topic #{topic}: validated payload #{payload}")

        client.deliver_message(payload, topic: topic)
        logger.info("[Producer] Topic #{topic}: delivered payload #{payload}")
      end

      private

      def client
        ::HeyKafka::Client.new.connect
      end

      def validator
        ::HeyKafka::Validator
      end

      def logger
        @logger ||= ::Logger.new(STDOUT)
      end
    end
  end
end
