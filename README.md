# Rails Custom Logging

An oponionated yet fully customizable way to tranform your Rails logs into useful data.

Currently supported Ruby versions: 2.6, 2.7, 3.0.
Currently supported Rails versions: 6.0, 6.1, 7.0

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rails_custom_logging'
```

## Usage

Enable the gem in an initializer or in any environment config:

```ruby
# config/initializers/logging.rb

RailsCustomLogging.configure do |config|
  config.enabled = Rails.env.production?
end
```

## Customization

TODO

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ccocchi/rails_custom_logging. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/ccocchi/rails_custom_logging/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the RailsCustomLogging project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/ccocchi/rails_custom_logging/blob/master/CODE_OF_CONDUCT.md).
