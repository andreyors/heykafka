# frozen_string_literal: true

module HeyKafka
  class Client
    attr_writer :logger

    def initialize
      @kafka_server = ENV['KAFKA_SERVER'] || 'kafka:9092'
      @client = ENV['KAFKA_CLIENT_ID'] || 'default'
    end

    def connect
      client = ::Kafka.new([@kafka_server], client_id: @client)
      logger.info("Connected client to broker #{@kafka_server}")

      client
    end

    private

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end
  end
end
