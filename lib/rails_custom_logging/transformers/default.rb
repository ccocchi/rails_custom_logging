# frozen_string_literal: true

module RailsCustomLogging
  module Transformers
    # Transforms a ActiveSupport::Notifications::Event into a Hash with
    # basic values any application could use.
    #
    module Default
      class << self
        def call(event)
          payload = event.payload.dup

          if payload.key?(:params)
            payload[:params] = payload[:params].except('action', 'controller', 'id')
            payload.delete(:params) if payload[:params].empty?
          end

          payload[:duration] = event.duration
          payload[:allocations] = event.allocations

          payload.delete(:headers)
          payload.delete(:response)
          payload[:path] = extract_path(payload)
          payload.delete(:request)

          payload
        end

        private

        if ::ActionPack::VERSION::MAJOR == 6 && ::ActionPack::VERSION::MINOR == 0
          def extract_path(payload)
            path  = payload[:path]
            index = path.index("?")
            index ? path.slice(0, index) : path
          end
        else
          def extract_path(payload)
            payload[:request].path
          end
        end
      end
    end
  end
end
