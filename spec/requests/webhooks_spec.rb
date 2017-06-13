require "rails_helper"

RSpec.describe "Webhooks", type: :request do
  it "requires a signature" do
    post webhooks_path, as: :json, params: {}
    expect(response).to have_http_status(:forbidden)
  end

  it "does not accept invalid requests" do
    payload = { "foo" => "bar" }
    post webhooks_url, as: :json, params: payload, headers: signature_header(payload, "boom!")
    expect(response).to have_http_status(:forbidden)
  end

  it "can receive and store a webhook" do
    payload = { "foo" => "bar" }
    post webhooks_url, as: :json, params: payload, headers: signature_header(payload)
    expect(response).to have_http_status(:success)
    expect(payload).to eq(Event.last.payload)
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
