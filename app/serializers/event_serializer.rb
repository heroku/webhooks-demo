class EventSerializer < ActiveModel::Serializer
  attributes :payload, :created_at
end
