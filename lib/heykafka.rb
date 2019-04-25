# frozen_string_literal: true

require 'heykafka/client'
require 'heykafka/consumer'
require 'heykafka/producer'
require 'heykafka/runner'
require 'heykafka/version'
require 'zeitwerk'

loader = Zeitwerk::Loader.new
loader.setup

module Heykafka
  class Error < StandardError
  end
end
