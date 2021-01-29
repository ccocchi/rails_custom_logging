# Backport `detach_from` method added in Rails 6
# https://github.com/rails/rails/blob/v6.1.1/activesupport/lib/active_support/subscriber.rb
#
module RailsLoggingFormatters
  module ActiveSupport
    module Subscriber
      def detach_from(namespace, notifier = ::ActiveSupport::Notifications)
        @namespace  = namespace
        @subscriber = subscribers.find { |s| s.instance_of?(self) }
        @notifier   = notifier

        return unless subscriber

        subscribers.delete(subscriber)

        # Remove event subscriber for all existing methods on the class.
        subscriber.public_methods(false).each do |event|
          remove_event_subscriber(event)
        end

        # Reset notifier so that event subscribers will not add for new methods added to the class.
        @notifier = nil
      end

      private

      def invalid_event?(event)
        %i[start finish].include?(event.to_sym)
      end

      def remove_event_subscriber(event)
        return if invalid_event?(event)

        pattern = "#{event}.#{namespace}"

        return unless subscriber.patterns.include?(pattern)

        subscriber.patterns.delete(pattern)
        ::ActiveSupport::Notifications.notifier.listeners_for(pattern).each do |li|
          if li.instance_variable_get(:@delegate) == subscriber
            notifier.unsubscribe(li)
          end
        end
      end
    end
  end
end

::ActiveSupport::Subscriber.extend(RailsLoggingFormatters::ActiveSupport::Subscriber)
