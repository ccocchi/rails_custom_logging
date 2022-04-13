module RailsCustomLogging
  class Railtie < Rails::Railtie
    initializer 'rails_custom_logging.middleware', after: :load_config_initializers do |app|
      if RailsCustomLogging.enabled?
        require_relative 'rails_ext/rack/logger'
        app.middleware.swap Rails::Rack::Logger, RailsCustomLogging::Rack::Logger
      end
    end

    config.after_initialize do |app|
      RailsCustomLogging.setup(app) if RailsCustomLogging.enabled?
    end
  end
end
