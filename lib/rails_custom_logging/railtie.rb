require_relative 'rails_ext/rack/logger'

module RailsCustomLogging
  class Railtie < Rails::Railtie
    initializer 'rails_custom_logging.middleware', after: :load_config_initializers do |app|
      if RailsCustomLogging.enabled?
        app.middleware.swap Rails::Rack::Logger, RailsCustomLogging::Rack::Logger
      end
    end

    config.after_initialize do |app|
      if RailsCustomLogging.enabled?
        if Rails::VERSION::MAJOR < 6
          # Adds missing `detach_from` method in subscriber
          require 'rails_custom_logging/rails_ext/active_support/subscriber'
        end

        RailsCustomLogging.setup(app)
      end
    end
  end
end
