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
    @travel_time    = data[:travel_time]
    @weather_at_eta = weather(data)
  end
  
  def weather(data)
    arrival = calculate_arrival(data)
    diff    = calculate_difference(data)
    if diff == "impossible"
      {}
    elsif diff > 24
      weather_day(data) #if it's over 24 hours
    else
      weather_hour(data)
    end
  end
  
  def weather_day(data)
    arrival = calculate_arrival(data)

    data[:weather][:forecast][:forecastday].find do |day|
      if arrival.include?(day[:date])
        hash =  {
                  datetime: day[:date],
                  temperature: day[:day][:avgtemp_f],
                  condition: day[:day][:condition][:text]
                }
        return hash
      end
    end
  end
  
  def weather_hour(data)
    arrival = calculate_arrival(data)
      data[:weather][:forecast][:forecastday].each do |day|
      day[:hour].each do |hour|
        hour_time    = Time.parse(hour[:time])
        ht_second    = hour_time.hour * 3600 + hour_time.min * 60 + hour_time.sec
        arrival_time = Time.parse(arrival)
        arr_second   = arrival_time.hour * 3600 + arrival_time.min * 60 + arrival_time.sec
        if (ht_second - arr_second).abs <= 3600 # check if arrival time is within the hour
          hash = {
                    datetime: hour[:time],
                    temperature: hour[:temp_f],
                    condition: hour[:condition][:text]
                  }
          return hash
        end
      end
    end
  end
  
  private
    def calculate_arrival(data)
      if @travel_time == "impossible"
        nil
      elsif @travel_time > "23:59:59"
        arrival = Chronic.parse(@travel_time)
        arrival.strftime("%Y-%m-%d %H:%M:%S") if arrival
      else
        time_trv  = Time.parse(@travel_time)
        seconds   = time_trv.hour * 3600 + time_trv.min * 60 + time_trv.sec
        arrival   = Time.now + seconds
        arrival.strftime("%Y-%m-%d %H:%M:%S") if arrival
      end
    end
    
    def calculate_difference(data)
      if @travel_time == "impossible"
        return "impossible"
      else
        arr_dtg    = calculate_arrival(data)
        
        arrival    = Time.parse(arr_dtg).to_i
        
        now        = Time.now.to_i
        
        seconds = arrival - now
        (seconds / 3600.00).round(1)
      end
    end
end