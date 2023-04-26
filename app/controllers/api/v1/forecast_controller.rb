class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
  
  private
    def forecast_params
      params.permit(:location)
    end
end