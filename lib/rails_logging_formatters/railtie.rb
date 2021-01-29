require_relative 'rails_ext/rack/logger'

module RailsLoggingFormatters
  class Railtie < Rails::Railtie
    initializer 'rails_logging_formatters.middleware', after: :load_config_initializers do |app|
      if RailsLoggingFormatters.enabled?
        app.middleware.swap Rails::Rack::Logger, RailsLoggingFormatters::Rack::Logger
      end
    end

    config.after_initialize do |app|
      if RailsLoggingFormatters.enabled?
        if Rails::VERSION::MAJOR < 6
          # Adds missing `detach_from` method in subscriber
          require 'rails_logging_formatters/rails_ext/active_support/subscriber'
        end

        RailsLoggingFormatters.setup(app)
      end
    end
  end
end
