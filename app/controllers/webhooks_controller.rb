class WebhooksController < ApplicationController
  def create
    payload = MultiJson.load(request.body.read)
    Event.create(payload: payload)
    # TODO ensure transaction around request?
    # TODO: trim events list?
  end
end
