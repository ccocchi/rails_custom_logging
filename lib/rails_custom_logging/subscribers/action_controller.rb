module RailsCustomLogging
  module Subscribers
    class ActionController < ::ActiveSupport::LogSubscriber
      def process_action(event)
        info do
          payload = RailsCustomLogging.transformer.call(event)
          RailsCustomLogging.formatter.call(payload)
        end
      end
    end
  end
end
