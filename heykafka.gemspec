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

  spec.add_runtime_dependency 'logger', '~> 1.5.0'
  spec.add_runtime_dependency 'json-schema', '~> 2.8.0'
  spec.add_runtime_dependency 'ruby-kafka', '~> 1.1'

  spec.add_development_dependency 'bundler', '~> 2.1'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.5.1'
  spec.add_development_dependency 'rubocop', '~> 1.28.1'
  spec.add_development_dependency 'rubocop-performance', '~> 1.13.2'
  spec.add_development_dependency 'simplecov', '~> 0.21.2'
end
