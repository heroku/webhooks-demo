class WebhooksController < ApplicationController
  def create
    Event.create(payload: params['webhook'])
    # TODO ensure transaction around request?
    # TODO: trim events list?
  end
end
