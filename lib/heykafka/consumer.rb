# frozen_string_literal: true

module HeyKafka
  class Consumer
    def topic
      raise NotImplementedError, 'Please implement topic'
    end

    def group
      topic
    end

    def run
      listen { |payload| process(payload) }
    end

    def process(_payload)
      raise NotImplementedError, 'Please implement process'
    end

    private

    def client
      ::HeyKafka::Client.new.connect
    end

    def listen
      consumer = client.consumer_path(group_id: group)
      consumer.subscribe(topic)

      consumer.each_message(automatically_mark_as_processed: false) do |message|
        yield JSON.parse(message&.value)

        consumer.mark_message_as_processed(message)
        consumer.commit_offsets
      end
    end
  end
end
