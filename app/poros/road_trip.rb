class RoadTrip
  attr_reader :id,
              :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(data)
    # binding.pry
    @id             = nil
    @start_city     = data[:start_city]
    @end_city       = data[:end_city]
    @travel_time    = data[:travel_time]
    @weather_at_eta = data[:weather]
    # binding.pry
  end
end