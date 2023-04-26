class RoadTripFacade
  def self.road_trip(data)
    # binding.pry
    route       = MapService.get_trip(data[:origin], data[:destination])
    # binding.pry
    if route[:info][:statuscode] == 402
      details = {
                  id: nil,
                  start_city: data[:origin],
                  end_city: data[:destination],
                  travel_time: "impossible",
                  weather: {}
                }
                RoadTrip.new(details)
    else
      forecast    = ForecastService.get_forecast(data[:destination])
      travel_time = format_time(route)
      details     = {
                      start_city: data[:origin],
                      end_city: data[:destination],
                      travel_time: travel_time,
                      weather: forecast,
                      time: travel_time
                    }
      # binding.pry
      RoadTrip.new(details)
    end
  end
  
  def self.format_time(route)
    route[:route][:formattedTime].split(':')
  end
end