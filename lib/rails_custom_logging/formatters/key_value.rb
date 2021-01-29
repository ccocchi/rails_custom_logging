# frozen_string_literal: true

module RailsCustomLogging
  module Formatters
    module KeyValue

      # MRI trick to force the order of the payload keys with a very light cost of a single
      # merge. MRI hash's `to_a` method will return values in the order in which they are
      # defined by implemention. `merge` follows the same pattern.
      #
      # If you're using another implemention of Ruby (jRuby/truffleruby) you might end up
      # with unordered keys.
      #
      ORDERED_HASH = {
        method: nil, path: nil, params: nil, format: nil, status: nil, controller: nil,
        action: nil, duration: nil, db_runtime: nil, view_runtime: nil, allocations: nil
      }

      class << self
        def call(payload)
          ordered_payload = ORDERED_HASH.merge(payload)
          ordered_payload.compact!

          ordered_payload.map { |key, value| format(key, value) }.join(' ')
        end

        private

        def format(key, value)
          formatted_value = value.is_a?(Float) ? Kernel.format('%.2f', value) : value
          "#{key}=#{formatted_value}"
        end
      end
    end
  end
end
