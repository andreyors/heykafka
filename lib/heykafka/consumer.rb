# frozen_string_literal: true

module HeyKafka
  class Consumer
    attr_writer :logger

    def topic
      raise NotImplementedError, 'Please implement topic'
    end

    def group
      topic
    end

    def run
      logger.info("Topic #{topic}: listening")

      listen do |payload|
        logger.info("[Consumer] Topic #{topic}: consumed message #{payload}")

        validator.validate!(payload: payload, topic: topic)
        logger.info("[Consumer] Topic #{topic}: validated message #{payload}")

        process(payload)
        logger.info("[Consumer] Topic #{topic}: processed message #{payload}")
      end
    ensure
      logger.info("Topic #{topic}: stop listening")
    end

    def process(_payload)
      raise NotImplementedError, 'Please implement process'
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

    def listen
      consumer = client.consumer(group_id: group)
      consumer.subscribe(topic)

      consumer.each_message(automatically_mark_as_processed: false) do |message|
        yield JSON.parse(message&.value)

        consumer.mark_message_as_processed(message)
        consumer.commit_offsets
      end
    end
  end
end
