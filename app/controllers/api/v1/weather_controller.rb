class Api::V1::ForecastController < ApplicationController
  def index
    weather = ForecastFacade.forecast(params[:location])
    binding.pry
    render json: ForecastSerializer.format_all(weather)
  end
end