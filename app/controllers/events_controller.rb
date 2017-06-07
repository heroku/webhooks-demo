class EventsController < ApplicationController
  def index
    @events = Event.take(3)
  end
end
