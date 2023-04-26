class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    @id             = nil
    @start_city     = data[:start_city]
    @end_city       = data[:end_city]
    @travel_time    = time(data)
    @weather_at_eta = weather(data)
  end
end