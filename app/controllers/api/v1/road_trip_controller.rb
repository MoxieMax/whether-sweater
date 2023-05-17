class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    if user
      trip = RoadTripFacade.road_trip(origin: params["origin"], destination: params["destination"])
      render json: RoadTripSerializer.new(trip), status: 201
    else
      render json: { error: 'Unauthorized', status: 401 }#, status: 401
    end
  end
  
  private
    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end

#needs api key validation