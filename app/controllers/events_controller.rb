class EventsController < ActionController::Base
  def index
    @events = Event.all
  end
end
