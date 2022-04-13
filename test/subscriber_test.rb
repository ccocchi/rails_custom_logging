require "test_helper"

class SubscriberTest < ActionController::TestCase
  class DummyController < ActionController::Base
    def index
      head(:no_content)
    end
  end

  tests DummyController

  def setup
    @routes = ActionDispatch::Routing::RouteSet.new
    @routes.draw { get "/dummy", to: "subscriber_test/dummy#index" }
  end

  private def get_event
    event = nil
    subscriber = proc do |*args|
      event = ActiveSupport::Notifications::Event.new(*args)
    end

    subscription = ActiveSupport::Notifications.subscribe(
      "process_action.action_controller",
      subscriber
    )

    get :index

    ActiveSupport::Notifications.unsubscribe(subscription)
    return event
  end

  def test_allocations_are_available
    event = get_event
    refute_nil event.allocations
  end

  def test_duration_is_present
    event = get_event
    refute_nil event.duration
  end

  def test_request_is_present
    event = get_event
    assert_instance_of ActionController::TestRequest, event.payload[:request]
  end
end
