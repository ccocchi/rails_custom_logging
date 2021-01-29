module RailsLoggingFormatters
  module Rack
    # Replace `Rails::Rack::Logger` middleware with this one to avoid pesky Rack logs
    # lines like `Started GET /`.
    #
    class Logger
      def initialize(app)
        @app = app
      end

      def call(env)
        @app.call(env)
      ensure
        ::ActiveSupport::LogSubscriber.flush_all!
      end
    end
  end
end
