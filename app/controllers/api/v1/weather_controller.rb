class Api::V1::WeatherController < ApplicationController
  def index
    weather = WeatherFacade.forecast(params[:location])
    render json: WeatherSerializer.format_all(weather)
  end
end