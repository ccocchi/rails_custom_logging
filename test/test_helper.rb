# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'active_support'
require 'action_controller'

require 'active_support/notifications/instrumenter'

require "rails_logging_formatters"

require "minitest/autorun"
