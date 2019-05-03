# frozen_string_literal: true

module HeyKafka
  class Loader
    CONSUMER_PATH = '/app/consumers/'

    def classify(name)
      file = consumer_path(name)
      raise LoadError, "Cannot find #{name} consumer in #{CONSUMER_PATH}" unless File.exist? file

      require file

      consumer = ::Object.const_get("::Consumers::#{name.capitalize}Consumer")
      consumer.new
    end

    private

    def consumer_path(name)
      "#{Dir.pwd}#{CONSUMER_PATH}#{name}_consumer.rb"
    end
  end
end
