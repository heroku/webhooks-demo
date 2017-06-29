class SetupController < ApplicationController

  def index
    @webhook_secret = ENV['WEBHOOK_SECRET']
    if Rails.env.development?
      @webhooks = 'https://$PUBLIC_HOST'+ webhooks_path
    else
      @webhooks = request.base_url + webhooks_path
    end
  end
end
