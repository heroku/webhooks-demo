class WebhooksController < ActionController::API
  def create
    digest  = OpenSSL::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['WEBHOOK_SECRET'], request.raw_post)).strip
    heroku_hmac = request.headers['Heroku-Webhook-Hmac-SHA256']

    if Rack::Utils.secure_compare(calculated_hmac, heroku_hmac)
      event = Event.create(payload: params['webhook'])
      ActionCable.server.broadcast 'events', event.payload
      # TODO ensure transaction around request?
      # TODO: trim events list?
    else
      render json: {'error' => 'signature_mismatch'}, status: 403
    end
  end
end
