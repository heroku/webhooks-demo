class EventsController < ApplicationController
  before_action :authenticate_user_action!

  def index
    render json: Event.last(3), each_serializer: EventSerializer
  end
end
