class Api::V1::ForecastController < ApplicationController
  def show
    binding.pry
    forecast = ForecastFacade.forecast(params[:location])
    binding.pry
    render json: ForecastSerializer.new(forecast)
  end
  
  private
    def forecast_params
      params.permit(:location)
    end
end