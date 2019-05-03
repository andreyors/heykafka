# frozen_string_literal: true

require 'bundler/setup'

if defined? ENV['COV']
  require 'simplecov'
end

require 'heykafka'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.example_status_persistence_file_path = '.rspec_status'

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  config.disable_monkey_patching!

  config.default_formatter = 'doc' if config.files_to_run.one?

  config.order = :random

  config.shared_context_metadata_behavior = :apply_to_host_groups

  original_stdout = $stdout.clone
  original_stderr = $stderr.clone

  config.before(:each) do
    $stderr.reopen File.new('/dev/null', 'w')
    $stdout.reopen File.new('/dev/null', 'w')
  end

  config.after(:each) do
    $stdout.reopen original_stdout
    $stderr.reopen original_stderr
  end
end
