class EventsController < ApplicationController
  before_action :authenticate_user_action!

  def index
    render json: EventList.events
  end
end
