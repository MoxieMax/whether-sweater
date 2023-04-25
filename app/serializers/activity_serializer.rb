class ActivitySerializer
  include JSONAPI::Serializer
  attributes :destination, :forecast, :activities
    set_type :activities
end