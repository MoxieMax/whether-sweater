class Api::V1::ActivitiesController < ApplicationController
  def index
    temp = ActivityFacade.get_weather(params[:destination])[:temperature]
    
    if temp >= 60
      activities = ActivityFacade.temp_over_60(params[:destination])
      render json: ActivitySerializer.new(activities)
    elsif temp < 50
      activities = ActivityFacade.temp_under_50(params[:destination])
      render json: ActivitySerializer.new(activities)
    else 
      activities = ActivityFacade.temp_between_50_60(params[:destination])
      render json: ActivitySerializer.new(activities)
    end
  end
  
  private
    def destination_params
      params.permit(:destination)
    end
end