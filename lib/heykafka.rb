# frozen_string_literal: true

# Gem deps
require 'logger'
require 'ruby-kafka'
require 'json-schema'
require 'json'

# Library deps
require 'heykafka/client'
require 'heykafka/consumer'
require 'heykafka/consumer_runner'
require 'heykafka/loader'
require 'heykafka/producer'
require 'heykafka/validator'
require 'heykafka/version'

module HeyKafka
  class Error < StandardError
  end

  class SchemaNotFoundError < StandardError
  end
end
