class SetupController < ApplicationController

  def index
    @webhook_secret = ENV['WEBHOOK_SECRET']
    @webhooks = request.base_url + webhooks_path
  end
end
