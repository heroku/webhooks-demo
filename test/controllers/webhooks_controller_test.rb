require 'test_helper'

class WebhooksControllerTest < ActionDispatch::IntegrationTest
  test "it requires a signature" do
    post webhooks_url, as: :json, params: {}
    assert_response :forbidden
  end

  test "it does not accept invalid requests" do
    payload = { "foo" => "bar" }
    post webhooks_url, as: :json, params: payload, headers: signature_header(payload, "boom!")
    assert_response :forbidden
  end

  test "can receive and store a webhook" do
    payload = { "foo" => "bar" }
    post webhooks_url, as: :json, params: payload, headers: signature_header(payload)
    assert_response :success
    assert_equal payload, Event.last.payload
  end

  def signature_header(payload, secret = ENV['WEBHOOK_SECRET'])
    signature = Base64.encode64(OpenSSL::HMAC.digest(
      OpenSSL::Digest.new('sha256'),
      secret,
      payload.to_json)
    ).strip

    {
      'Heroku-Webhook-Hmac-SHA256' => signature
    }
  end
end
