class SetupController < ApplicationController

  before_action do
    @webhook_secret = ENV['WEBHOOK_SECRET']
    if Rails.env.development?
      @webhooks = 'https://$PUBLIC_HOST'+ webhooks_path
    else
      @webhooks = request.base_url + webhooks_path
    end
  end

  def index

  end

  def ci

  end
end
