require "test_helper"

class KeyValueFormatterTest < Minitest::Test
  def test_empty_payload
    assert_equal '', RailsLoggingFormatters::Formatters::KeyValue.call({})
  end

  def test_missing_values_are_not_printed
    str = RailsLoggingFormatters::Formatters::KeyValue.call({ method: 'GET', path: '/' })
    assert_equal 'method=GET path=/', str
  end

  def test_order_is_respected
    unordered = {
      path:       '/',
      format:     'json',
      method:     'GET',
      action:     'index',
      controller: 'Users',
      status:     200
    }

    str = RailsLoggingFormatters::Formatters::KeyValue.call(unordered)
    assert_equal 'method=GET path=/ format=json status=200 controller=Users action=index', str
  end

  def test_float_are_rounded
    str = RailsLoggingFormatters::Formatters::KeyValue.call({ status: 200, duration: 128.397462 })
    assert_equal 'status=200 duration=128.40', str
  end
end
