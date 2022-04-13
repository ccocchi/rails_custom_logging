# frozen_string_literal: true

module RailsCustomLogging
  module Transformers
    # Transforms a ActiveSupport::Notifications::Event into a Hash with
    # basic values any application could use.
    #
    module Default
      def self.call(event)
        payload = event.payload.dup

        if payload.key?(:params)
          payload[:params] = payload[:params].except('action', 'controller', 'id')
          payload.delete(:params) if payload[:params].empty?
        end

        payload[:duration] = event.duration
        payload[:allocations] = event.allocations

        payload.delete(:headers)
        payload.delete(:response)
        payload[:path] = payload[:request].path
        payload.delete(:request)

        payload
      end
    end
  end
end
