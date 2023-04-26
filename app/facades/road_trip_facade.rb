class RoadTripFacade
  def self.road_trip(data)
    # binding.pry
    route       = MapService.get_trip(data[:origin], data[:destination])
    forecast    = ForecastService.get_forecast(data[:destination])
    travel_time = format_time(route)
    # binding.pry
    
    details = {
                start_city: data[:origin],
                end_city: data[:destination],
                travel_time: travel_time,
                weather: forecast,
                time: travel_time
              }
    # binding.pry
    RoadTrip.new(details)
  end
  
  def self.format_time(route)
    # binding.pry
    route[:formattedTime].split(':')# if route[:routeError][:errorCode] == (-400)
  end
end