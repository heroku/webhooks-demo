class WebhooksController < ActionController::API
  def create
    event = Event.create(payload: params['webhook'])
    serialized_event = ActiveModelSerializers::SerializableResource.new(event, {serializer: EventSerializer})
    ActionCable.server.broadcast 'events', serialized_event
  end
end
