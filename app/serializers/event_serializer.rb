class EventSerializer < ActiveModel::Serializer
  attributes :created_at, :payload
end
