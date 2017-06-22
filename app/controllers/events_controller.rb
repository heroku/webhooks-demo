class EventsController < ApplicationController
  before_action :authenticate_user_action!

  def index
    render json: Event.order(created_at: :asc).limit(100), each_serializer: EventSerializer
  end
end
