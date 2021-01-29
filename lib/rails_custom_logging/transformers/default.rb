# frozen_string_literal: true

module RailsCustomLogging
  module Transformers
    module Default
      def self.call(event)
        payload = event.payload.dup

        payload[:params]    = payload[:params]&.except('action', 'controller', 'id')
        payload[:duration]  = event.duration

        payload.delete(:headers)
        payload.delete(:params) if payload[:params]&.empty?

        payload
      end
    end
  end
end
