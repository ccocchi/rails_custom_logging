require 'test_helper'

class DefaultTransformerTest < Minitest::Test
  def setup
    @payload = {
      method: 'GET',
      path: '/users',
      controller: 'Users',
      action: 'show'
    }
  end

  private def build_event
    ::ActiveSupport::Notifications::Event.new(
      'process_action.action_controller',
      Process.clock_gettime(Process::CLOCK_MONOTONIC),
      Process.clock_gettime(Process::CLOCK_MONOTONIC) + 100,
      "transaction-id",
      @payload
    )
  end

  def test_original_payload_is_not_modified
    event = build_event
    event.payload.freeze

    RailsLoggingFormatters::Transformers::Default.call(event)

    assert_nil @payload[:duration]
  end

  def test_params_are_filtered
    @payload[:params] = { 'action' => 'index', 'controller' => 'users', 'sort' => 'created_at' }
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)

    assert_equal({ 'sort' => 'created_at' }, result[:params])
  end

  def test_empty_params_are_removed
    @payload[:params] = { 'action' => 'index', 'controller' => 'users' }
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)

    refute result.key?(:params)
  end

  def test_event_duration_is_added
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)
    assert_instance_of Float, result[:duration]
  end

  def test_headers_are_removed
    @payload[:headers] = { 'Accept' => 'application/json' }
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)
    refute result.key?(:headers)
  end

  def test_generic_action_controller_values_are_present
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)
    assert_equal 'GET', result[:method]
    assert_equal '/users', result[:path]
  end

  def test_user_specified_values_are_present
    @payload[:custom_value] = 'my-user-value'
    result = RailsLoggingFormatters::Transformers::Default.call(build_event)
    assert_equal 'my-user-value', result[:custom_value]
  end
end
