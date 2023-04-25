class Api::V1::ActivitiesController < ApplicationController
  def index
    # binding.pry
    # provide one relaxation activity
    # if the temperature is >= 60 F, include one recreational activity.
    # if the temperature is >= 50 F and < 60 F, include one busywork activity.
    # if the temperature is < 50 F, include one cooking activity.
    forecast = ForecastFacade.forecast(params[:destination]).current_weather
    binding.pry
    
    render json: ForecastSerializer.new(forecast.current_weather)#.current_weather
    # binding.pry
  end
  
  private
    def destination_params
      params.permit(:destination)
    end
end