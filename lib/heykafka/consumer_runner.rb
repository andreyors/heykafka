# frozen_string_literal: true

module HeyKafka
  class ConsumerRunner
    def parse!(options)
      @options = options

      self
    end

    def call
      name = @options.first
      raise ArgumentError, 'Please provide consumer name' unless name

      logger.info("[CLI] Starting consumer #{name}")

      consumer = loader.classify(name)
      consumer.run
    ensure
      logger.info("[CLI] Stopping consumer #{name}")
    end

    private

    def logger
      @logger ||= ::Logger.new(STDOUT)
    end

    def loader
      ::HeyKafka::Loader.new
    end
  end
end
