# frozen_string_literal: true

require_relative 'rails_custom_logging/version'
require_relative 'rails_custom_logging/configuration'
require_relative 'rails_custom_logging/subscribers/action_controller'
require_relative 'rails_custom_logging/transformers/default'
require_relative 'rails_custom_logging/formatters/key_value'
require_relative 'rails_custom_logging/railtie' if defined?(Rails)

module RailsCustomLogging
  class Error < StandardError; end

  def self.setup(app)
    # Remove Rails default subscribers
    ActionController::LogSubscriber.detach_from :action_controller
    ActionView::LogSubscriber.detach_from :action_view

    # Add our own
    Subscribers::ActionController.attach_to :action_controller
  end

  def self.configure
    yield configuration
  end

  def self.configuration
    @_configuration ||= Configuration.new
  end

  def self.formatter
    configuration.formatter
  end

  def self.transformer
    configuration.transformer
  end

  def self.enabled?
    configuration.enabled == true
  end
end
