# frozen_string_literal: true

module HeyKafka
  class Consumer
    def self.listen_to(topic, group = nil)
      @topic = topic
      @group = group || topic
    end

    def run
      listen { |payload| process(payload) }
    end
    
    def process(_payload)
      p @topic, @group
      # raise NotImplementedError, "Please implement process(payload)"
    end

    private

    def client
      ::HeyKafka::Client.new.connect
    end
    
    def listen
      consumer = client.consumer(group_id: @group.to_s)
      consumer.subscribe(@topic.to_s)
      
      consumer.each_message(automatically_mark_as_processed: false) do |message|
        yield JSON.parse(message&.value) if block_given?
        
        consumer.mark_message_as_processed(message)
        consumer.commit_offsets
      end
    end
  end
end
