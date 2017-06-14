class EventsController < ApplicationController
  def index
    render json: Event.last(3), each_serializer: EventSerializer
  end
end
