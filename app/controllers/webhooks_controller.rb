class WebhooksController < ApplicationController
  def create
    digest  = OpenSSL::Digest.new('sha256')
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest(digest, ENV['WEBHOOK_SECRET'], request.raw_post)).strip
    logger.info(calculated_hmac)
    logger.info(request.headers['Heroku-Webhook-Hmac-SHA256'])
    Event.create(payload: params['webhook'])
    # TODO ensure transaction around request?
    # TODO: trim events list?
  end
end
