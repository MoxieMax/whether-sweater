class Combo
  attr_reader :weather_hash,
              :salaries_hash
  
  def initialize(weather, salaries)
    
    @weather_hash = weather.current_weather
    @salaries_hash = salaries.jobs
    # binding.pry
  end
end