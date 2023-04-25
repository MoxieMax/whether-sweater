class ActivityFacade
  def temp # >= 60 F(destination)
    forecast = ForecastFacade.forecast(params[:destination]).current_weather
  end
  
  def temp # >= 50 F and < 60 F
    forecast = ForecastFacade.forecast(params[:destination]).current_weather
  end
  
  def temp # < 50 F
    forecast = ForecastFacade.forecast(params[:destination]).current_weather
  end
end