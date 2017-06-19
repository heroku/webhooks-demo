class DashboardController < ApplicationController
  before_action :authenticate_user_action!

  def index
    @webhook_secret = ENV['WEBHOOK_SECRET']
    @webhooks = request.base_url + webhooks_path
  end
end
