# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'heykafka/version'

Gem::Specification.new do |spec|
  spec.name          = 'heykafka'
  spec.version       = ::HeyKafka::VERSION
  spec.platform      = Gem::Platform::RUBY

  spec.authors       = ['Andrey Orsoev']
  spec.email         = %w[andrey.orsoev@gmail.com]

  spec.homepage      = 'https://github.com/heyjobs/heykafka'
  spec.summary       = 'Ruby based framework for building Kafka consumers'
  spec.description   = 'Internal tool used by Heyjobs'
  spec.license       = 'MIT'

  # spec.files = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(spec)/})
  # end
  spec.files         = Dir['**/**/*']

  spec.bindir        = 'exe'
  spec.executables   = %w[consumer]
  spec.require_paths = %w[lib]

  spec.required_ruby_version = '>= 2.4.4'

  spec.add_runtime_dependency 'logger', '~> 1.4.2'
  spec.add_runtime_dependency 'json-schema', '~> 2.8.0'
  spec.add_runtime_dependency 'ruby-kafka', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.4.1'
  spec.add_development_dependency 'rubocop', '~> 0.86.0'
  spec.add_development_dependency 'rubocop-performance', '~> 1.1.0'
  spec.add_development_dependency 'simplecov', '~> 0.16.1'
end
