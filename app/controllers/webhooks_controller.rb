class WebhooksController < ApplicationController
  def create
    logger.info(request.body.read.inspect)
  end
end
