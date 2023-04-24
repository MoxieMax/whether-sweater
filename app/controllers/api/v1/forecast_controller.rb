class Api::V1::ForecastController < ApplicationController
  def index
    forecast = ForecastFacade.forecast(params[:location])
    # binding.pry
    render json: ForecastSerializer.new(forecast)
  end
end