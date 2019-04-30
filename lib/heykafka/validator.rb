# frozen_string_literal: true

module HeyKafka
  class Validator
    class << self
      def validate!(payload:, topic:)
        schema = load_schema(topic)

        JSON::Validator.validate!(schema, payload)

        true
      end

      private

      def load_schema(topic)
        path = schema_path(topic)

        content = File.read(path)

        JSON.parse(content)
      rescue Errno::ENOENT
        fail SchemaNotFoundError, "Cannot find schema '#{topic}' to validate a payload"
      end

      def schema_path(name)
        "#{Dir.pwd}/config/validators/#{name}.json"
      end
    end
  end
end
