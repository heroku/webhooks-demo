class EventsController < ApplicationController
  def index
    render json: Event.take(3), each_serializer: EventSerializer
  end
end
