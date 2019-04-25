# frozen_string_literal: true

require 'ruby-kafka'

module HeyKafka
  class Client
    def initialize
      @kafka_server = ENV['KAFKA_SERVER'] || 'kafka:9092'
      @client = ENV['KAFKA_CLIENT'] || 'default'
    end

    def connect
      ::Kafka.new([@kafka_server], client_id: @client)
    end
  end
end
