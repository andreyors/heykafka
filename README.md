# Heykafka

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/heykafka`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'heykafka'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install heykafka

## Usage

We are using environment variables to provide credentials to client.

- `KAFKA_SERVER`, it specifies the broker connection string 
- `KAFKA_CLIENT_ID`

### Producer
`HeyKafka::Producer.send_message(message: 'some payload', topic: 'event_detected')`    

### Consumer

Place into following folder '/app/consumers/' 

```
module Consumers
  class TestConsumer < ::HeyKafka::Consumer
    def topic
      'test'
    end

    def process(payload)
      Rails.logger.info "Test Consumer is active, payload: #{JSON.parse(payload)}"
    end
  end
end  
```

### Consumer runner

`consumer <consumer-name>` (e.g. `consumer test`)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/heykafka.
