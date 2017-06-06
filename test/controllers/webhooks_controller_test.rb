require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "can receive and store a webhook" do
    payload = { "foo" => "bar" }
    post webhooks_url, as: :json, params: payload
    assert_response :success
    assert_equal payload, Event.last.payload
  end
end
