class Api::V1::RoadTripController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])
    # binding.pry
    trip = RoadTripFacade.road_trip(origin: params["origin"], destination: params["destination"])
    binding.pry
  end
  
  private
    def road_trip_params
      params.permit(:origin, :destination, :api_key)
    end
end