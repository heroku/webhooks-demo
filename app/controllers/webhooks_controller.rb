class WebhooksController < ApplicationController
  def create
    event = request.body.read
    logger.info(event)
    # TODO: store event in DB events table
  end
end
