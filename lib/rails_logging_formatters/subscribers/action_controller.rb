module RailsLoggingFormatters
  module Subscribers
    class ActionController < ::ActiveSupport::LogSubscriber
      def process_action(event)
        info do
          payload = RailsLoggingFormatters.transformer.call(event)
          RailsLoggingFormatters.formatter.call(payload)
        end
      end
    end
  end
end
