class DashboardController < ApplicationController
  #before_action :authenticate_user_action!

  def index
    @no_events = Event.count == 0
  end
end
