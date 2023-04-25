class Api::V1::ActivitiesController < ApplicationController
  def index
    # binding.pry
    # provide one relaxation activity
    # if the temperature is >= 60 F, include one recreational activity.
    # if the temperature is >= 50 F and < 60 F, include one busywork activity.
    # if the temperature is < 50 F, include one cooking activity.
    temp = ActivityFacade.get_weather(params[:destination])[:temperature]
    
    if temp >= 60
      ActivityFacade.temp_over_60(params[:destination])
      #render json
    elsif temp < 50
      ActivityFacade.temp_under_50(params[:destination])
      #render json
    else 
      ActivityFacade.temp_between_50_60(params[:destination])
      #render json
    # forecast = ForecastFacade.forecast(params[:destination]).current_weather
    end
    binding.pry
    
    # render json: ForecastSerializer.new(forecast.current_weather)#.current_weather
    # binding.pry
  end
  
  private
    def destination_params
      params.permit(:destination)
    end
end