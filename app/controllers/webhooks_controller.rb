class WebhooksController < ApplicationController
  def create
    digest  = OpenSSL::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['WEBHOOK_SECRET'], request.raw_post)).strip
    heroku_hmac = request.headers['Heroku-Webhook-Hmac-SHA256']

    if Rack::Utils.secure_compare(calculated_hmac, heroku_hmac)
      Event.create(payload: params['webhook'])
      # TODO ensure transaction around request?
      # TODO: trim events list?
    else
      render json: {'error' => 'signature_mismatch'}, status: 403
    end
  end
end
