# frozen_string_literal: true

module HeyKafka
    class Runner
        def parse!(options)
            @options = options
        end
        
        def execute
            name = @options.first
            raise ArgumentError, 'Please provide consumer name' unless name
            
            file = consumer(name)
            raise LoadError, "Cannot find #{file}" unless File.exist? file
            
            require file
            consumer = ::Consumers.const_get("#{name.capitalize}Consumer").new
            consumer.run
        end
        
        private
        
        def consumer(name)
            "#{Dir.pwd}/app/consumers/#{name}_consumer.rb"
        end
    end
end
